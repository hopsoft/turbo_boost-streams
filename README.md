<p align="center">
  <img height="200" src="https://ik.imagekit.io/hopsoft/turbo-ready-logo_jYFJI1jgT.png?ik-sdk-version=javascript-1.4.3&updatedAt=1661471047153" />
  <h1 align="center">
    Welcome to TurboReady 👋
  </h1>
  <h3 align="center">
    Turbo Stream's Swiss Army Knife
  </h3>
  <p align="center">
    <a href="http://blog.codinghorror.com/the-best-code-is-no-code-at-all/" target="_blank">
      <img alt="Lines of Code" src="https://img.shields.io/badge/lines_of_code-275-brightgreen.svg?style=flat" />
    </a>
    <a href="https://github.com/testdouble/standard" target="_blank">
      <img alt="Ruby Code Style" src="https://img.shields.io/badge/Ruby_Code_Style-standard-brightgreen.svg" />
    </a>
    <a href="https://github.com/sheerun/prettier-standard" target="_blank">
      <img alt="JavaScript Code Style" src="https://img.shields.io/badge/JavaScript_Code_Style-prettier_standard-ff69b4.svg" />
    </a>
  </p>
</p>

TurboReady extends [Turbo Streams](https://turbo.hotwired.dev/reference/streams) to give you full control of the browser's [Document Object Model (DOM).](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)

**Thats right!**
You can `invoke` any DOM method on any DOM object *(including 3rd party libs)* with Turbo Streams.

```ruby
turbo_stream.invoke "console.log", "Hello World!"
```

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Why TurboReady?](#why-turboready)
    - [Caution](#caution)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Advanced Usage](#advanced-usage)
  - [Public API and Method Signature](#public-api-and-method-signature)
  - [License](#license)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Why TurboReady?

Turbo Streams [intentionally restricts](https://turbo.hotwired.dev/handbook/streams#but-what-about-running-javascript) official actions to CRUD related activity.
The offical actions work well for a considerable number of use cases and you should push Streams as far as possible before reaching for TurboReady.

If you discover that CRUD isn't enough, TurboReady covers pretty much everything else.

### Caution

Manually orchestrating DOM activity becomes tedious very quickly.
**Don't abuse the superpowers that TurboReady provides!** ⚠️

> With great power comes great responsibility.

This library is an extremely sharp tool. 🔪
You should limit its usage.
Consider it a low-level building block that can be used to craft additional libraries with
great [DX](https://en.wikipedia.org/wiki/User_experience#Developer_experience)
like [CableReady](https://github.com/stimulusreflex/cable_ready)
and [StimulusReflex](https://github.com/stimulusreflex/stimulus_reflex).

Restrict direct application usage to discrete and surgical DOM manipulation that falls outside the scope of
[Turbo's official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions)...
*and for Pete's sake, don't overdo it and find yourself in spaghetti code reminicent of the jQuery days.*

## Dependencies

- [rails](https://rubygems.org/gems/rails) `>=7.0`
- [turbo-rails](https://rubygems.org/gems/turbo-rails) `>=1.1`
- [@hotwired/turbo-rails](https://yarnpkg.com/package/@hotwired/turbo-rails) `>=7.2.0-beta.2`

## Installation

```sh
bundle add "turbo_ready --version VERSION"
yarn add "turbo_ready@VERSION --exact"
```

**IMPORTANT:** Be sure to use the same version for each libary.

## Setup

1. Create a Rails intializer and patch Turbo.

    ```ruby
    # config/initializers/turbo_ready.rb
    TurboReady.patch! # Adds TurboReady stream actions to Turbo
    ```
2. Import and intialize TurboReady in your JavaScript application.

    ```js
    // app/javascript/application.js
    import '@hotwired/turbo-rails'
    import TurboReady from 'turbo_ready'

    TurboReady.initialize(Turbo.StreamActions) // Adds TurboReady stream actions to Turbo
    ```

## Usage

Manipulate the DOM from anywhere you use the [standard CRUD Turbo Streams](https://turbo.hotwired.dev/handbook/streams#integration-with-server-side-frameworks).
Namely, [ActiveRecord models](https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb),
[Controllers](https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb),
and [view templates](https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb).

```ruby
turbo_stream.invoke "setAttribute", "data-turbo-ready", true, selector: ".button"
```

You can even **chain invocations.** ❤️

```ruby
turbo_stream
  .invoke("document.body.insertAdjacentHTML", "afterbegin", "<h1>Hello World!</h1>") # dot notation
  .invoke("setAttribute", "data-turbo-ready", true, selector: ".button") # selector
  .invoke("classList.add", "turbo-ready", selector: "a") # dot notation + selector
  .flush # flush must be called when chaining invocations
```

You can use [dot notation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors#dot_notation) or a [selector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)... you can even **use them together!** 🤯

Can I dispatch events? **You bet!** ⚡️

```ruby
turbo_stream
  .invoke("dispatchEvent", "turbo-ready:demo") // fires on window
  .invoke("dispatchEvent", "turbo-ready:demo", selector: "#my-element") // fires on matching element(s)
  .invoke("dispatchEvent", {bubbles: true, detail: {...}}) // set event options
  .flush
```

**Wondering what else is possible?**
MDN has your back... [learn about the DOM and web APIs here.](https://developer.mozilla.org/en-US/docs/Web/API.)

## Advanced Usage

Want to add functionality with custom JavaScript? **Let's go.** 🔌

```js
import morphdom from 'morphdom'

window.MyNamespace = {
  morph: (from, to, options = {}) => {
    morphdom(document.querySelector(from), to, options)
  }
}
```

```ruby
turbo_stream.invoke "MyNamespace.morph", "#demo", "<div id='demo'><p>You've changed...</p></div>", {childrenOnly: true}
```

**Even better...** use Ruby symbols and [snake case](https://en.wikipedia.org/wiki/Snake_case) when invoking DOM functionality.
It's implicitly converted to [camel case](https://en.wikipedia.org/wiki/Camel_case) for you.

```ruby
turbo_stream
  .invoke(:animate, [{opacity: 0}, {opacity: 1}], 2000)
  .invoke(:dispatch_event, {detail: {converts_camel_case: true}})
  .flush
```

Need to opt out? No problem... just disable it.

```ruby
turbo_stream.invoke :contrived_demo, camelize: false
```

## Public API

There's only one method to consider, `invoke` defined in the
[tag builder](https://github.com/hopsoft/turbo_ready/blob/main/lib/turbo_ready/tag_builder.rb).

```ruby
turbo_stream
  .invoke(method, *args, selector: nil, camelize: true, id: nil)
#         |        |     |              |               |
#         |        |     |              |               |- Identifies this invocation (optional)
#         |        |     |              |
#         |        |     |              |- Should we camelize method & Hash keys passed as args? (optional)
#         |        |     |                 (allows us to write snake_case Ruby)
#         |        |     |
#         |        |     |- An CSS selector for the element(s) to target (optional)
#         |        |
#         |        |- The arguments to pass to the JavaScript method being invoked (optional)
#         |
#         |- The JavaScript method to invoke (can use dot notation)
```

**NOTE:** The JavaScript method will be invoked on all matching elements when a selector is passed.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

---

<p align="center">
  <strong><em>Open Source development sponsored by:</em></strong>
</p>

<p align="center">
  <a href="https://www.clickfunnels.com?utm_source=hopsoft&utm_medium=open-source&utm_campaign=turbo_ready">
    <img src="https://images.clickfunnel.com/uploads/digital_asset/file/176632/clickfunnels-dark-logo.svg" width="575" />
  </a>
</p>
