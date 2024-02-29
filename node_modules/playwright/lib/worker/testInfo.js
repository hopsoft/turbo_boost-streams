"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.TestInfoImpl = void 0;
var _fs = _interopRequireDefault(require("fs"));
var _path = _interopRequireDefault(require("path"));
var _utils = require("playwright-core/lib/utils");
var _timeoutManager = require("./timeoutManager");
var _util = require("../util");
var _testTracing = require("./testTracing");
function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }
/**
 * Copyright Microsoft Corporation. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

class TestInfoImpl {
  get error() {
    return this.errors[0];
  }
  set error(e) {
    if (e === undefined) throw new Error('Cannot assign testInfo.error undefined value!');
    this.errors[0] = e;
  }
  get timeout() {
    return this._timeoutManager.defaultSlotTimings().timeout;
  }
  set timeout(timeout) {
    // Ignored.
  }
  _deadlineForMatcher(timeout) {
    const startTime = (0, _utils.monotonicTime)();
    const matcherDeadline = timeout ? startTime + timeout : _utils.MaxTime;
    const testDeadline = this._timeoutManager.currentSlotDeadline() - 250;
    const matcherMessage = `Timeout ${timeout}ms exceeded while waiting on the predicate`;
    const testMessage = `Test timeout of ${this.timeout}ms exceeded`;
    return {
      deadline: Math.min(testDeadline, matcherDeadline),
      timeoutMessage: testDeadline < matcherDeadline ? testMessage : matcherMessage
    };
  }
  static _defaultDeadlineForMatcher(timeout) {
    return {
      deadline: timeout ? (0, _utils.monotonicTime)() + timeout : 0,
      timeoutMessage: `Timeout ${timeout}ms exceeded while waiting on the predicate`
    };
  }
  constructor(configInternal, projectInternal, workerParams, test, retry, onStepBegin, onStepEnd, onAttach) {
    var _test$id, _test$_requireFile, _test$title, _test$titlePath, _test$location$file, _test$location$line, _test$location$column, _test$fn, _test$expectedStatus;
    this._onStepBegin = void 0;
    this._onStepEnd = void 0;
    this._onAttach = void 0;
    this._timeoutManager = void 0;
    this._startTime = void 0;
    this._startWallTime = void 0;
    this._hasHardError = false;
    this._tracing = void 0;
    this._didTimeout = false;
    this._wasInterrupted = false;
    this._lastStepId = 0;
    this._requireFile = void 0;
    this._projectInternal = void 0;
    this._configInternal = void 0;
    this._steps = [];
    this._onDidFinishTestFunction = void 0;
    this._hasNonRetriableError = false;
    // ------------ TestInfo fields ------------
    this.testId = void 0;
    this.repeatEachIndex = void 0;
    this.retry = void 0;
    this.workerIndex = void 0;
    this.parallelIndex = void 0;
    this.project = void 0;
    this.config = void 0;
    this.title = void 0;
    this.titlePath = void 0;
    this.file = void 0;
    this.line = void 0;
    this.column = void 0;
    this.fn = void 0;
    this.expectedStatus = void 0;
    this.duration = 0;
    this.annotations = [];
    this.attachments = [];
    this.status = 'passed';
    this.snapshotSuffix = '';
    this.outputDir = void 0;
    this.snapshotDir = void 0;
    this.errors = [];
    this._attachmentsPush = void 0;
    this.testId = (_test$id = test === null || test === void 0 ? void 0 : test.id) !== null && _test$id !== void 0 ? _test$id : '';
    this._onStepBegin = onStepBegin;
    this._onStepEnd = onStepEnd;
    this._onAttach = onAttach;
    this._startTime = (0, _utils.monotonicTime)();
    this._startWallTime = Date.now();
    this._requireFile = (_test$_requireFile = test === null || test === void 0 ? void 0 : test._requireFile) !== null && _test$_requireFile !== void 0 ? _test$_requireFile : '';
    this.repeatEachIndex = workerParams.repeatEachIndex;
    this.retry = retry;
    this.workerIndex = workerParams.workerIndex;
    this.parallelIndex = workerParams.parallelIndex;
    this._projectInternal = projectInternal;
    this.project = projectInternal.project;
    this._configInternal = configInternal;
    this.config = configInternal.config;
    this.title = (_test$title = test === null || test === void 0 ? void 0 : test.title) !== null && _test$title !== void 0 ? _test$title : '';
    this.titlePath = (_test$titlePath = test === null || test === void 0 ? void 0 : test.titlePath()) !== null && _test$titlePath !== void 0 ? _test$titlePath : [];
    this.file = (_test$location$file = test === null || test === void 0 ? void 0 : test.location.file) !== null && _test$location$file !== void 0 ? _test$location$file : '';
    this.line = (_test$location$line = test === null || test === void 0 ? void 0 : test.location.line) !== null && _test$location$line !== void 0 ? _test$location$line : 0;
    this.column = (_test$location$column = test === null || test === void 0 ? void 0 : test.location.column) !== null && _test$location$column !== void 0 ? _test$location$column : 0;
    this.fn = (_test$fn = test === null || test === void 0 ? void 0 : test.fn) !== null && _test$fn !== void 0 ? _test$fn : () => {};
    this.expectedStatus = (_test$expectedStatus = test === null || test === void 0 ? void 0 : test.expectedStatus) !== null && _test$expectedStatus !== void 0 ? _test$expectedStatus : 'skipped';
    this._timeoutManager = new _timeoutManager.TimeoutManager(this.project.timeout);
    this.outputDir = (() => {
      const relativeTestFilePath = _path.default.relative(this.project.testDir, this._requireFile.replace(/\.(spec|test)\.(js|ts|mjs)$/, ''));
      const sanitizedRelativePath = relativeTestFilePath.replace(process.platform === 'win32' ? new RegExp('\\\\', 'g') : new RegExp('/', 'g'), '-');
      const fullTitleWithoutSpec = this.titlePath.slice(1).join(' ');
      let testOutputDir = (0, _util.trimLongString)(sanitizedRelativePath + '-' + (0, _utils.sanitizeForFilePath)(fullTitleWithoutSpec));
      if (projectInternal.id) testOutputDir += '-' + (0, _utils.sanitizeForFilePath)(projectInternal.id);
      if (this.retry) testOutputDir += '-retry' + this.retry;
      if (this.repeatEachIndex) testOutputDir += '-repeat' + this.repeatEachIndex;
      return _path.default.join(this.project.outputDir, testOutputDir);
    })();
    this.snapshotDir = (() => {
      const relativeTestFilePath = _path.default.relative(this.project.testDir, this._requireFile);
      return _path.default.join(this.project.snapshotDir, relativeTestFilePath + '-snapshots');
    })();
    this._attachmentsPush = this.attachments.push.bind(this.attachments);
    this.attachments.push = (...attachments) => {
      for (const a of attachments) this._attach(a.name, a);
      return this.attachments.length;
    };
    this._tracing = new _testTracing.TestTracing(this, workerParams.artifactsDir);
  }
  _modifier(type, modifierArgs) {
    if (typeof modifierArgs[1] === 'function') {
      throw new Error(['It looks like you are calling test.skip() inside the test and pass a callback.', 'Pass a condition instead and optional description instead:', `test('my test', async ({ page, isMobile }) => {`, `  test.skip(isMobile, 'This test is not applicable on mobile');`, `});`].join('\n'));
    }
    if (modifierArgs.length >= 1 && !modifierArgs[0]) return;
    const description = modifierArgs[1];
    this.annotations.push({
      type,
      description
    });
    if (type === 'slow') {
      this._timeoutManager.slow();
    } else if (type === 'skip' || type === 'fixme') {
      this.expectedStatus = 'skipped';
      throw new SkipError('Test is skipped: ' + (description || ''));
    } else if (type === 'fail') {
      if (this.expectedStatus !== 'skipped') this.expectedStatus = 'failed';
    }
  }
  async _runWithTimeout(cb) {
    const timeoutError = await this._timeoutManager.runWithTimeout(cb);
    // When interrupting, we arrive here with a timeoutError, but we should not
    // consider it a timeout.
    if (!this._wasInterrupted && timeoutError && !this._didTimeout) {
      this._didTimeout = true;
      const serialized = (0, _util.serializeError)(timeoutError);
      this.errors.push(serialized);
      this._tracing.appendForError(serialized);
      // Do not overwrite existing failure upon hook/teardown timeout.
      if (this.status === 'passed' || this.status === 'skipped') this.status = 'timedOut';
    }
    this.duration = this._timeoutManager.defaultSlotTimings().elapsed | 0;
  }
  async _runAndFailOnError(fn, skips) {
    try {
      await fn();
    } catch (error) {
      if (skips === 'allowSkips' && error instanceof SkipError) {
        if (this.status === 'passed') this.status = 'skipped';
      } else {
        this._failWithError(error, true /* isHardError */, true /* retriable */);
        return error;
      }
    }
  }
  _findLastNonFinishedStep(filter) {
    let result;
    const visit = step => {
      if (!step.endWallTime && filter(step)) result = step;
      step.steps.forEach(visit);
    };
    this._steps.forEach(visit);
    return result;
  }
  _addStep(data) {
    var _parentStep3, _parentStep4;
    const stepId = `${data.category}@${++this._lastStepId}`;
    const rawStack = (0, _utils.captureRawStack)();
    let parentStep;
    if (data.category === 'hook' || data.category === 'fixture') {
      // Predefined steps form a fixed hierarchy - find the last non-finished one.
      parentStep = this._findLastNonFinishedStep(step => step.category === 'fixture' || step.category === 'hook');
    } else {
      var _parentStep, _parentStep2;
      parentStep = _utils.zones.zoneData('stepZone', rawStack) || undefined;
      if (((_parentStep = parentStep) === null || _parentStep === void 0 ? void 0 : _parentStep.category) === 'hook' || ((_parentStep2 = parentStep) === null || _parentStep2 === void 0 ? void 0 : _parentStep2.category) === 'fixture') {
        // Prefer last non-finished predefined step over the on-stack one, because
        // some predefined steps may be missing on the stack.
        parentStep = this._findLastNonFinishedStep(step => step.category === 'fixture' || step.category === 'hook');
      } else if (!parentStep) {
        if (data.category === 'test.step') {
          // Nest test.step without a good stack in the last non-finished predefined step like a hook.
          parentStep = this._findLastNonFinishedStep(step => step.category === 'fixture' || step.category === 'hook');
        } else {
          // Do not nest chains of route.continue.
          parentStep = this._findLastNonFinishedStep(step => step.title !== data.title);
        }
      }
    }
    if (data.forceNoParent) {
      // This is used to reset step hierarchy after test timeout.
      parentStep = undefined;
    }
    const filteredStack = (0, _util.filteredStackTrace)(rawStack);
    data.boxedStack = (_parentStep3 = parentStep) === null || _parentStep3 === void 0 ? void 0 : _parentStep3.boxedStack;
    if (!data.boxedStack && data.box) {
      data.boxedStack = filteredStack.slice(1);
      data.location = data.location || data.boxedStack[0];
    }
    data.location = data.location || filteredStack[0];
    const step = {
      stepId,
      ...data,
      steps: [],
      complete: result => {
        if (step.endWallTime) return;
        step.endWallTime = Date.now();
        if (result.error) {
          if (!result.error[stepSymbol]) result.error[stepSymbol] = step;
          const error = (0, _util.serializeError)(result.error);
          if (data.boxedStack) error.stack = `${error.message}\n${(0, _utils.stringifyStackFrames)(data.boxedStack).join('\n')}`;
          step.error = error;
        }
        if (!step.error) {
          // Soft errors inside try/catch will make the test fail.
          // In order to locate the failing step, we are marking all the parent
          // steps as failing unconditionally.
          for (const childStep of step.steps) {
            if (childStep.error && childStep.infectParentStepsWithError) {
              step.error = childStep.error;
              step.infectParentStepsWithError = true;
              break;
            }
          }
        }
        const payload = {
          testId: this.testId,
          stepId,
          wallTime: step.endWallTime,
          error: step.error
        };
        this._onStepEnd(payload);
        const errorForTrace = step.error ? {
          name: '',
          message: step.error.message || '',
          stack: step.error.stack
        } : undefined;
        this._tracing.appendAfterActionForStep(stepId, errorForTrace, result.attachments);
        if (step.isSoft && result.error) this._failWithError(result.error, false /* isHardError */, true /* retriable */);
      }
    };
    const parentStepList = parentStep ? parentStep.steps : this._steps;
    parentStepList.push(step);
    const payload = {
      testId: this.testId,
      stepId,
      parentStepId: parentStep ? parentStep.stepId : undefined,
      title: data.title,
      category: data.category,
      wallTime: data.wallTime,
      location: data.location
    };
    this._onStepBegin(payload);
    this._tracing.appendBeforeActionForStep(stepId, (_parentStep4 = parentStep) === null || _parentStep4 === void 0 ? void 0 : _parentStep4.stepId, data.apiName || data.title, data.params, data.wallTime, data.location ? [data.location] : []);
    return step;
  }
  _interrupt() {
    // Mark as interrupted so we can ignore TimeoutError thrown by interrupt() call.
    this._wasInterrupted = true;
    this._timeoutManager.interrupt();
    // Do not overwrite existing failure (for example, unhandled rejection) with "interrupted".
    if (this.status === 'passed') this.status = 'interrupted';
  }
  _failWithError(error, isHardError, retriable) {
    if (!retriable) this._hasNonRetriableError = true;
    // Do not overwrite any previous hard errors.
    // Some (but not all) scenarios include:
    //   - expect() that fails after uncaught exception.
    //   - fail after the timeout, e.g. due to fixture teardown.
    if (isHardError && this._hasHardError) return;
    if (isHardError) this._hasHardError = true;
    if (this.status === 'passed' || this.status === 'skipped') this.status = 'failed';
    const serialized = (0, _util.serializeError)(error);
    const step = error[stepSymbol];
    if (step && step.boxedStack) serialized.stack = `${error.name}: ${error.message}\n${(0, _utils.stringifyStackFrames)(step.boxedStack).join('\n')}`;
    this.errors.push(serialized);
    this._tracing.appendForError(serialized);
  }
  async _runAsStepWithRunnable(stepInfo, cb) {
    return await this._timeoutManager.withRunnable({
      type: stepInfo.runnableType,
      slot: stepInfo.runnableSlot,
      location: stepInfo.location
    }, async () => {
      return await this._runAsStep(stepInfo, cb);
    });
  }
  async _runAsStep(stepInfo, cb) {
    const step = this._addStep({
      wallTime: Date.now(),
      ...stepInfo
    });
    return await _utils.zones.run('stepZone', step, async () => {
      try {
        const result = await cb(step);
        step.complete({});
        return result;
      } catch (e) {
        step.complete({
          error: e instanceof SkipError ? undefined : e
        });
        throw e;
      }
    });
  }
  _isFailure() {
    return this.status !== 'skipped' && this.status !== this.expectedStatus;
  }

  // ------------ TestInfo methods ------------

  async attach(name, options = {}) {
    this._attach(name, await (0, _util.normalizeAndSaveAttachment)(this.outputPath(), name, options));
  }
  _attach(name, attachment) {
    var _attachment$body;
    const step = this._addStep({
      title: `attach "${name}"`,
      category: 'attach',
      wallTime: Date.now()
    });
    this._attachmentsPush(attachment);
    this._onAttach({
      testId: this.testId,
      name: attachment.name,
      contentType: attachment.contentType,
      path: attachment.path,
      body: (_attachment$body = attachment.body) === null || _attachment$body === void 0 ? void 0 : _attachment$body.toString('base64')
    });
    step.complete({
      attachments: [attachment]
    });
  }
  outputPath(...pathSegments) {
    const outputPath = this._getOutputPath(...pathSegments);
    _fs.default.mkdirSync(this.outputDir, {
      recursive: true
    });
    return outputPath;
  }
  _getOutputPath(...pathSegments) {
    const joinedPath = _path.default.join(...pathSegments);
    const outputPath = (0, _util.getContainedPath)(this.outputDir, joinedPath);
    if (outputPath) return outputPath;
    throw new Error(`The outputPath is not allowed outside of the parent directory. Please fix the defined path.\n\n\toutputPath: ${joinedPath}`);
  }
  _fsSanitizedTestName() {
    const fullTitleWithoutSpec = this.titlePath.slice(1).join(' ');
    return (0, _utils.sanitizeForFilePath)((0, _util.trimLongString)(fullTitleWithoutSpec));
  }
  snapshotPath(...pathSegments) {
    const subPath = _path.default.join(...pathSegments);
    const parsedSubPath = _path.default.parse(subPath);
    const relativeTestFilePath = _path.default.relative(this.project.testDir, this._requireFile);
    const parsedRelativeTestFilePath = _path.default.parse(relativeTestFilePath);
    const projectNamePathSegment = (0, _utils.sanitizeForFilePath)(this.project.name);
    const snapshotPath = (this._projectInternal.snapshotPathTemplate || '').replace(/\{(.)?testDir\}/g, '$1' + this.project.testDir).replace(/\{(.)?snapshotDir\}/g, '$1' + this.project.snapshotDir).replace(/\{(.)?snapshotSuffix\}/g, this.snapshotSuffix ? '$1' + this.snapshotSuffix : '').replace(/\{(.)?testFileDir\}/g, '$1' + parsedRelativeTestFilePath.dir).replace(/\{(.)?platform\}/g, '$1' + process.platform).replace(/\{(.)?projectName\}/g, projectNamePathSegment ? '$1' + projectNamePathSegment : '').replace(/\{(.)?testName\}/g, '$1' + this._fsSanitizedTestName()).replace(/\{(.)?testFileName\}/g, '$1' + parsedRelativeTestFilePath.base).replace(/\{(.)?testFilePath\}/g, '$1' + relativeTestFilePath).replace(/\{(.)?arg\}/g, '$1' + _path.default.join(parsedSubPath.dir, parsedSubPath.name)).replace(/\{(.)?ext\}/g, parsedSubPath.ext ? '$1' + parsedSubPath.ext : '');
    return _path.default.normalize(_path.default.resolve(this._configInternal.configDir, snapshotPath));
  }
  skip(...args) {
    this._modifier('skip', args);
  }
  fixme(...args) {
    this._modifier('fixme', args);
  }
  fail(...args) {
    this._modifier('fail', args);
  }
  slow(...args) {
    this._modifier('slow', args);
  }
  setTimeout(timeout) {
    this._timeoutManager.setTimeout(timeout);
  }
}
exports.TestInfoImpl = TestInfoImpl;
class SkipError extends Error {}
const stepSymbol = Symbol('step');