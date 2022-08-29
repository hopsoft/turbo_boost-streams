<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://ik.imagekit.io/hopsoft/turbo-ready-logo-light_df4jcvbDL.webp?ik-sdk-version=javascript-1.4.3&updatedAt=1661615678275">
    <img height="200" src="https://ik.imagekit.io/hopsoft/turbo-ready-logo-dark_VN4hA2ctc.webp?ik-sdk-version=javascript-1.4.3&updatedAt=1661615678278" />
  </picture>
  <h3 align="center">
    Turbo Stream's Swiss Army Knife
  </h3>
  <h1 align="center">
    Welcome to TurboReady 👋
  </h1>
  <p align="center">
    <a href="http://blog.codinghorror.com/the-best-code-is-no-code-at-all/" target="_blank">
      <img alt="Lines of Code" src="https://img.shields.io/badge/loc-278-47d299.svg" />
    </a>
    <a href="https://codeclimate.com/github/hopsoft/turbo_ready/maintainability" target="_blank">
      <img src="https://api.codeclimate.com/v1/badges/a69b6f73abc3ccd49261/maintainability" />
    </a>
    <a href="https://rubygems.org/gems/turbo_ready" target="_blank">
      <img alt="GEM" src="https://img.shields.io/gem/v/turbo_ready?color=168AFE&include_prereleases&logo=ruby&logoColor=FE1616">
    </a>
    <a href="https://rubygems.org/gems/turbo_ready" target="_blank">
      <img alt="Gem" src="https://img.shields.io/gem/dt/turbo_ready?color=168AFE&logo=ruby&logoColor=FE1616">
    </a>
    <a href="https://github.com/testdouble/standard" target="_blank">
      <img alt="Ruby Style" src="https://img.shields.io/badge/style-standard-168AFE?logo=ruby&logoColor=FE1616" />
    </a>
    <a href="https://www.npmjs.com/package/turbo_ready" target="_blank">
      <img alt="NPM" src="https://img.shields.io/npm/v/turbo_ready?color=168AFE&logo=npm">
    </a>
    <a href="https://www.npmjs.com/package/turbo_ready" target="_blank">
      <img alt="npm" src="https://img.shields.io/npm/dm/turbo_ready?color=168AFE&logo=npm">
    </a>
    <a href="https://bundlephobia.com/package/turbo_ready@" target="_blank">
      <img alt="npm bundle size" src="https://img.shields.io/bundlephobia/minzip/turbo_ready?label=bundle%20size&logo=javascript&color=47d299">
    </a>
    <a href="https://github.com/sheerun/prettier-standard" target="_blank">
      <img alt="JavaScript Style" src="https://img.shields.io/badge/style-prettier--standard-168AFE?logo=javascript&logoColor=f4e137" />
    </a>
    <a href="https://twitter.com/hopsoft" target="_blank">
      <img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/hopsoft?logo=twitter&style=social">
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
  - [Sponsors](#sponsors)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Advanced Usage](#advanced-usage)
  - [What Else Can I Do?](#what-else-can-i-do)
    - [Extending Behavior](#extending-behavior)
  - [Public API](#public-api)
  - [A Word of Caution](#a-word-of-caution)
  - [Community](#community)
    - [Discord](#discord)
    - [Discussions](#discussions)
    - [Twitter](#twitter)
  - [Releasing](#releasing)
  - [License](#license)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Why TurboReady?

Turbo Streams [intentionally restricts](https://turbo.hotwired.dev/handbook/streams#but-what-about-running-javascript%3F)
official actions to CRUD related activity.
The [official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions) work well for a
considerable number of use cases and you should push Streams as far as possible before reaching for TurboReady.

If you discover that CRUD isn't enough, TurboReady covers pretty much everything else.

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

- [rails](https://rubygems.org/gems/rails) `>=6.1`
- [turbo-rails](https://rubygems.org/gems/turbo-rails) `>=1.1`
- [@hotwired/turbo-rails](https://yarnpkg.com/package/@hotwired/turbo-rails) `>=7.2.0-beta.2`

## Installation

```sh
bundle add "turbo_ready --version VERSION"
yarn add "turbo_ready@VERSION --exact"
```

**IMPORTANT:** Be sure to use the same version for each libary.

## Setup

1. Import and intialize TurboReady in your application.

    ```diff
    # Gemfile
    +gem "turbo_ready", "~> 0.0.5"
    ```

    ```diff
    # package.json
    "dependencies": {
    +  "@hotwired/turbo-rails": ">=7.2.0-beta.2",
    +  "turbo_ready": "^0.0.5"
    ```

    ```diff
    # app/javascript/application.js
    import '@hotwired/turbo-rails'
    +import TurboReady from 'turbo_ready'

    +TurboReady.initialize(Turbo.StreamActions) // Adds TurboReady stream actions to Turbo
    ```

## Usage

Manipulate the DOM from anywhere you use [official Turbo Streams](https://turbo.hotwired.dev/handbook/streams#integration-with-server-side-frameworks).
Namely, [**M**odels](https://guides.rubyonrails.org/active_model_basics.html),
[**V**iews](https://guides.rubyonrails.org/action_view_overview.html),
[**C**ontrollers](https://guides.rubyonrails.org/action_controller_overview.html)
and [Jobs](https://guides.rubyonrails.org/active_job_basics.html).

You can **chain invocations.** ❤️

```ruby
turbo_stream
  .invoke("document.body.insertAdjacentHTML", "afterbegin", "<h1>Hello World!</h1>") # dot notation
  .invoke("setAttribute", "data-turbo-ready", true, selector: ".button") # selector
  .invoke("classList.add", "turbo-ready", selector: "a") # dot notation + selector
  .flush # flush must be called when chaining invocations
```

You can use [dot notation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors#dot_notation)
or [selectors](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)... **and can even combine them!** 🤯

Can I dispatch events? **You bet!** ⚡️

```ruby
turbo_stream
  .invoke("dispatchEvent", "turbo-ready:demo") # fires on window
  .invoke("document.dispatchEvent", "turbo-ready:demo") # fires on document
  .invoke("dispatchEvent", "turbo-ready:demo", selector: "#my-element") # fires on matching element(s)
  .invoke("dispatchEvent", {bubbles: true, detail: {...}}) # set event options
  .flush
```

## Advanced Usage

You can use symbols and [snake case](https://en.wikipedia.org/wiki/Snake_case) when invoking DOM functionality.
It'll implicitly convert to [camel case](https://en.wikipedia.org/wiki/Camel_case). 💎

```ruby
turbo_stream
  .invoke(:animate, [{opacity: 0}, {opacity: 1}], 2000, selector: "#example")
  .invoke(:dispatch_event, {detail: {converts_to_camel_case: true}}, selector: "#example")
  .flush
```

Need to opt out of camelize? No problem... just disable it.

```ruby
turbo_stream.invoke :contrived_demo, camelize: false
```

## What Else Can I Do?

**The possibilities are endless**
and MDN has your back... [learn about the DOM and web APIs here.](https://developer.mozilla.org/en-US/docs/Web/API.)

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
*don't overdo it and find yourself maintaining spaghetti code reminiscent of the jQuery days.*

## Community

### Discord

Please join nearly 2000 of us on [Discord](https://discord.gg/stimulus-reflex) for support getting started,
as well as active discussions around Rails, Hotwire, Stimulus, Turbo (Drive, Frames, Streams), TurboReady, CableReady, StimulusReflex, ViewComponent, Phlex, and more.

<a href="https://discord.gg/stimulus-reflex" target="_blank">
  <img alt="Discord" src="https://img.shields.io/discord/629472241427415060?color=168AFE&logo=discord&logoColor=FFF">
</a>

Be sure to introduce yourselves in the #newcomers channel!

### Discussions

Feel free to add to the conversation here on [GitHub Discussions](https://github.com/hopsoft/turbo_ready/discussions).

<a href="https://github.com/hopsoft/turbo_ready/discussions" target="_blank">
  <img alt="GitHub Discussions" src="https://img.shields.io/github/discussions/hopsoft/turbo_ready?color=168AFE&logo=github">
</a>

### Twitter

Connect with the core team on Twitter.

<a href="https://twitter.com/hopsoft" target="_blank">
  <img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/hopsoft?logo=twitter&style=social">
</a>

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
