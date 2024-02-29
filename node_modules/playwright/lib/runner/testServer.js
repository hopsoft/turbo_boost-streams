"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.runTestServer = runTestServer;
var _path = _interopRequireDefault(require("path"));
var _utils = require("playwright-core/lib/utils");
var _configLoader = require("../common/configLoader");
var _internalReporter = require("../reporters/internalReporter");
var _multiplexer = require("../reporters/multiplexer");
var _reporters = require("./reporters");
var _tasks = require("./tasks");
var _runner = require("./runner");
var _util = require("../util");
var _base = require("../reporters/base");
var _loadUtils = require("./loadUtils");
var _reporterV = require("../reporters/reporterV2");
function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }
/**
 * Copyright (c) Microsoft Corporation.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

async function runTestServer() {
  if ((0, _configLoader.restartWithExperimentalTsEsm)(undefined, true)) return null;
  process.env.PW_TEST_HTML_REPORT_OPEN = 'never';
  const wss = new _utils.WSServer({
    onConnection(request, url, ws, id) {
      const dispatcher = new Dispatcher(ws);
      ws.on('message', async message => {
        const {
          id,
          method,
          params
        } = JSON.parse(String(message));
        try {
          const result = await dispatcher[method](params);
          ws.send(JSON.stringify({
            id,
            result
          }));
        } catch (e) {
          // eslint-disable-next-line no-console
          console.error(e);
        }
      });
      return {
        async close() {}
      };
    }
  });
  const url = await wss.listen(0, 'localhost', '/' + (0, _utils.createGuid)());
  // eslint-disable-next-line no-console
  process.on('exit', () => wss.close().catch(console.error));
  // eslint-disable-next-line no-console
  console.log(`Listening on ${url}`);
  process.stdin.on('close', () => (0, _utils.gracefullyProcessExitDoNotHang)(0));
}
class Dispatcher {
  constructor(ws) {
    this._testRun = void 0;
    this._ws = void 0;
    this._ws = ws;
    process.stdout.write = (chunk, cb, cb2) => {
      this._dispatchEvent('stdio', chunkToPayload('stdout', chunk));
      if (typeof cb === 'function') cb();
      if (typeof cb2 === 'function') cb2();
      return true;
    };
    process.stderr.write = (chunk, cb, cb2) => {
      this._dispatchEvent('stdio', chunkToPayload('stderr', chunk));
      if (typeof cb === 'function') cb();
      if (typeof cb2 === 'function') cb2();
      return true;
    };
  }
  async listFiles(params) {
    try {
      const config = await this._loadConfig(params.configFile);
      const runner = new _runner.Runner(config);
      return runner.listTestFiles();
    } catch (e) {
      const error = (0, _util.serializeError)(e);
      error.location = (0, _base.prepareErrorStack)(e.stack).location;
      return {
        projects: [],
        error
      };
    }
  }
  async listTests(params) {
    const config = await this._loadConfig(params.configFile);
    config.cliArgs = params.locations || [];
    const wireReporter = await this._createReporter(params.reporter);
    const reporter = new _internalReporter.InternalReporter(new _multiplexer.Multiplexer([wireReporter]));
    const taskRunner = (0, _tasks.createTaskRunnerForList)(config, reporter, 'out-of-process', {
      failOnLoadErrors: true
    });
    const testRun = new _tasks.TestRun(config, reporter);
    reporter.onConfigure(config.config);
    const taskStatus = await taskRunner.run(testRun, 0);
    let status = testRun.failureTracker.result();
    if (status === 'passed' && taskStatus !== 'passed') status = taskStatus;
    const modifiedResult = await reporter.onEnd({
      status
    });
    if (modifiedResult && modifiedResult.status) status = modifiedResult.status;
    await reporter.onExit();
  }
  async test(params) {
    var _params$projects;
    await this._stopTests();
    const overrides = {
      repeatEach: 1,
      retries: 0,
      preserveOutputDir: true,
      use: {
        trace: params.trace,
        headless: params.headed ? false : undefined,
        _optionContextReuseMode: params.reuseContext ? 'when-possible' : undefined,
        _optionConnectOptions: params.connectWsEndpoint ? {
          wsEndpoint: params.connectWsEndpoint
        } : undefined
      },
      workers: params.oneWorker ? 1 : undefined
    };
    const config = await this._loadConfig(params.configFile, overrides);
    config.cliListOnly = false;
    config.cliArgs = params.locations || [];
    config.cliGrep = params.grep;
    config.cliProjectFilter = (_params$projects = params.projects) !== null && _params$projects !== void 0 && _params$projects.length ? params.projects : undefined;
    const wireReporter = await this._createReporter(params.reporter);
    const configReporters = await (0, _reporters.createReporters)(config, 'run');
    const reporter = new _internalReporter.InternalReporter(new _multiplexer.Multiplexer([...configReporters, wireReporter]));
    const taskRunner = (0, _tasks.createTaskRunnerForTestServer)(config, reporter);
    const testRun = new _tasks.TestRun(config, reporter);
    reporter.onConfigure(config.config);
    const stop = new _utils.ManualPromise();
    const run = taskRunner.run(testRun, 0, stop).then(async status => {
      await reporter.onEnd({
        status
      });
      await reporter.onExit();
      this._testRun = undefined;
      return status;
    });
    this._testRun = {
      run,
      stop
    };
    await run;
  }
  async findRelatedTestFiles(params) {
    const config = await this._loadConfig(params.configFile);
    const runner = new _runner.Runner(config);
    return runner.findRelatedTestFiles('out-of-process', params.files);
  }
  async stop(params) {
    await this._stopTests();
  }
  async closeGracefully() {
    (0, _utils.gracefullyProcessExitDoNotHang)(0);
  }
  async _stopTests() {
    var _this$_testRun, _this$_testRun2;
    (_this$_testRun = this._testRun) === null || _this$_testRun === void 0 || (_this$_testRun = _this$_testRun.stop) === null || _this$_testRun === void 0 || _this$_testRun.resolve();
    await ((_this$_testRun2 = this._testRun) === null || _this$_testRun2 === void 0 ? void 0 : _this$_testRun2.run);
  }
  _dispatchEvent(method, params) {
    this._ws.send(JSON.stringify({
      method,
      params
    }));
  }
  async _loadConfig(configFile, overrides) {
    return (0, _configLoader.loadConfig)({
      resolvedConfigFile: configFile,
      configDir: _path.default.dirname(configFile)
    }, overrides);
  }
  async _createReporter(file) {
    const reporterConstructor = await (0, _loadUtils.loadReporter)(undefined, file);
    const instance = new reporterConstructor(message => this._dispatchEvent('report', message));
    return (0, _reporterV.wrapReporterAsV2)(instance);
  }
}
function chunkToPayload(type, chunk) {
  if (chunk instanceof Buffer) return {
    type,
    buffer: chunk.toString('base64')
  };
  return {
    type,
    text: chunk
  };
}