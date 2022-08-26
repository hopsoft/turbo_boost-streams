<p align="center">
  <img height="200" src="https://ik.imagekit.io/hopsoft/turbo-ready-logo_jYFJI1jgT.png?ik-sdk-version=javascript-1.4.3&updatedAt=1661471047153" />
  <h3 align="center">
    Turbo Stream's Swiss Army Knife
  </h3>
  <h1 align="center">
    Welcome to TurboReady 👋
  </h1>
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

TurboReady extends [Turbo Streams](https://turbo.hotwired.dev/reference/streams) to give you full control of the
browser's [Document Object Model (DOM).](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)

**Thats right!**
You can `invoke` any DOM method on any DOM object *(including 3rd party libs)* using Turbo Streams.

```ruby
turbo_stream.invoke "console.log", "Hello World!"
```

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Why TurboReady?](#why-turboready)
  - [Discord Community](#discord-community)
  - [Sponsors](#sponsors)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Endless Possibilities](#endless-possibilities)
  - [Advanced Usage](#advanced-usage)
    - [Extending Behavior](#extending-behavior)
  - [Public API](#public-api)
  - [A Word of Caution](#a-word-of-caution)
  - [Releasing](#releasing)
  - [License](#license)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Why TurboReady?

Turbo Streams [intentionally restricts](https://turbo.hotwired.dev/handbook/streams#but-what-about-running-javascript)
official actions to CRUD related activity.
The [official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions) work well for a
considerable number of use cases and you should push Streams as far as possible before reaching for TurboReady.

If you discover that CRUD isn't enough, TurboReady covers pretty much everything else.

## Discord Community

Please join nearly 2000 of us on [Discord](https://discord.gg/stimulus-reflex) for support getting started,
as well as active discussions around Rails, Hotwire, Stimulus, Turbo (Drive, Frames, Streams), TurboReady, CableReady, and StimulusReflex.

![](https://img.shields.io/discord/629472241427415060)

Stop by #newcomers and introduce yourselves!

## Sponsors

<p align="center">
  <em>Proudly sponsored by</em>
</p>
<p align="center">
  <a href="https://www.clickfunnels.com?utm_source=hopsoft&utm_medium=open-source&utm_campaign=turbo_ready">
    <img src="https://images.clickfunnel.com/uploads/digital_asset/file/176632/clickfunnels-dark-logo.svg" width="575" />
  </a>
</p>

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

Manipulate the DOM from anywhere you use [official Turbo Streams](https://turbo.hotwired.dev/handbook/streams#integration-with-server-side-frameworks).
Namely, [**M**odels](https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb),
[**V**iews](https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb),
and [**C**ontrollers](https://github.com/hotwired/turbo-rails/blob/main/app/models/concerns/turbo/broadcastable.rb).

You can **chain invocations.** ❤️

```ruby
turbo_stream
  .invoke("document.body.insertAdjacentHTML", "afterbegin", "<h1>Hello World!</h1>") # dot notation
  .invoke("setAttribute", "data-turbo-ready", true, selector: ".button") # selector
  .invoke("classList.add", "turbo-ready", selector: "a") # dot notation + selector
  .flush # flush must be called when chaining invocations
```

You can use [dot notation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors#dot_notation)
or [selectors](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)... and can even combine them!** 🤯

Can I dispatch events? **You bet!** ⚡️

```ruby
turbo_stream
  .invoke("dispatchEvent", "turbo-ready:demo") // fires on window
  .invoke("dispatchEvent", "turbo-ready:demo", selector: "#my-element") // fires on matching element(s)
  .invoke("dispatchEvent", {bubbles: true, detail: {...}}) // set event options
  .flush
```

## Endless Possibilities

**What else can I do?**
MDN has your back... [learn about the DOM and web APIs here.](https://developer.mozilla.org/en-US/docs/Web/API.)

## Advanced Usage

You can use symbols and [snake case](https://en.wikipedia.org/wiki/Snake_case) when invoking DOM functionality.
It'll implicitly convert to [camel case](https://en.wikipedia.org/wiki/Camel_case). 💎

```ruby
turbo_stream
  .invoke(:animate, [{opacity: 0}, {opacity: 1}], 2000)
  .invoke(:dispatch_event, {detail: {converts_to_camel_case: true}})
  .flush
```

Need to opt out of camelize? No problem... just disable it.

```ruby
turbo_stream.invoke :contrived_demo, camelize: false
```

### Extending Behavior

Want to extend things with custom functionality? **Let's do it.** 🔌

```js
// JavaScript
import morphdom from 'morphdom'

window.MyNamespace = {
  morph: (from, to, options = {}) => {
    morphdom(document.querySelector(from), to, options)
  }
}
```

```ruby
# Ruby
turbo_stream
  .invoke "MyNamespace.morph", "#demo", "<div id='demo'><p>You've changed...</p></div>", {childrenOnly: true}
```

## Public API

There's only one method to consider, `invoke` defined in the
[tag builder](https://github.com/hopsoft/turbo_ready/blob/main/lib/turbo_ready/tag_builder.rb).

```ruby
# Ruby
turbo_stream
  .invoke(method, *args, selector: nil, camelize: true, id: nil)
#         |        |     |              |               |
#         |        |     |              |               |- Identifies this invocation (optional)
#         |        |     |              |
#         |        |     |              |- Should we camelize the JavaScript stuff? (optional)
#         |        |     |                 (allows us to write snake_case Ruby)
#         |        |     |
#         |        |     |- An CSS selector for the element(s) to target (optional)
#         |        |
#         |        |- The arguments to pass to the JavaScript method being invoked (optional)
#         |
#         |- The JavaScript method to invoke (can use dot notation)
```

**NOTE:** The JavaScript method will be invoked on all matching elements when a `selector` is passed.

## A Word of Caution

Manually orchestrating DOM activity gets tedious fast.
**⚠️ Don't abuse this superpower!**

> With great power comes great responsibility. *-Uncle Ben*

This library is an extremely sharp tool. 🔪
Consider it a low-level building block that can be used to craft additional libraries with
great [DX](https://en.wikipedia.org/wiki/User_experience#Developer_experience)
like [CableReady](https://github.com/stimulusreflex/cable_ready)
and [StimulusReflex](https://github.com/stimulusreflex/stimulus_reflex).

Restrict your direct application usage to DOM manipulation that falls outside the purview of
[Turbo's official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions)...
*and for Pete's sake, don't overdo it and find yourself maintaining spaghetti code reminiscent of the jQuery days.*

## Releasing

1. Run `yarn` and `bundle` to pick up the latest
1. Bump version number at `lib/turbo_ready/version.rb`. Pre-release versions use `.preN`
1. Run `rake build` and `yarn build`
1. Run `bin/standardize`
1. Commit and push changes to GitHub
1. Run `rake release`
1. Run `yarn publish --no-git-tag-version`
1. Yarn will prompt you for the new version. Pre-release versions use `-preN`
1. Commit and push changes to GitHub
1. Create a new release on GitHub ([here](https://github.com/hopsoft/turbo_ready/releases)) and generate the changelog for the stable release for it

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
