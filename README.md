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
      <img alt="Lines of Code" src="https://img.shields.io/badge/loc-307-47d299.svg" />
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
      <img alt="npm bundle size" src="https://img.shields.io/bundlephobia/minzip/turbo_ready?label=bundle%20size&logo=npm&color=47d299">
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

```ruby
turbo_stream.invoke "console.log", args: ["Hello World!"]
```

**Thats right!**
You can `invoke` any DOM method on the client with Turbo Streams.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Why TurboReady?](#why-turboready)
  - [Sponsors](#sponsors)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Usage](#usage)
    - [Method Chaining](#method-chaining)
    - [Dispatching Events](#dispatching-events)
    - [Syntax Styles](#syntax-styles)
    - [Extending Behavior](#extending-behavior)
    - [Implementation Details](#implementation-details)
  - [Broadcasting](#broadcasting)
    - [Configuration](#configuration)
  - [FAQ](#faq)
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
These [official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions) work well for a large number of use cases.
*You should push Turbo Streams as far as possible before reaching for TurboReady.*

But if you find that CRUD isn't enough, TurboReady covers pretty much everything else.

⚠️ TurboReady is intended for Rails apps that use Hotwire but not [CableReady](https://github.com/stimulusreflex/cable_ready).
This is because CableReady already provides a rich set of powerful [DOM operations](https://cableready.stimulusreflex.com/reference/operations).

💡 Efforts are underway to bring [CableReady's DOM operations to Turbo Streams](https://github.com/marcoroth/turbo_power).

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

⚠️ Be sure to use the same version for each libary.

## Setup

Import and intialize TurboReady in your application.

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

Manipulate the DOM from anywhere you use official [Turbo Streams](https://turbo.hotwired.dev/handbook/streams#integration-with-server-side-frameworks).
*Namely, [**M**odels](https://guides.rubyonrails.org/active_model_basics.html),
[**V**iews](https://guides.rubyonrails.org/action_view_overview.html),
[**C**ontrollers](https://guides.rubyonrails.org/action_controller_overview.html)
and [Jobs](https://guides.rubyonrails.org/active_job_basics.html).*

The possibilities are endless.
[Learn about the DOM on MDN.](https://developer.mozilla.org/en-US/docs/Web/API.)

```ruby
turbo_stream.invoke "console.log", args: ["Hello World!"]
```

### Method Chaining

📘 You can use [dot notation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors#dot_notation)
or [selectors](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)... even combine them!

```ruby
turbo_stream
  .invoke("document.body.insertAdjacentHTML", args: ["afterbegin", "<h1>Hello World!</h1>"]) # dot notation
  .invoke("setAttribute", args: ["data-turbo-ready", true], selector: ".button") # selector
  .invoke("classList.add", args: ["turbo-ready"], selector: "a") # dot notation + selector
  .flush # call flush when chaining invocations
```

### Dispatching Events

```ruby
turbo_stream
  .invoke("dispatchEvent", args: ["turbo-ready:demo"]) # fires on window
  .invoke("document.dispatchEvent", args: ["turbo-ready:demo"]) # fires on document
  .invoke("dispatchEvent", args: ["turbo-ready:demo"], selector: "#my-element") # fires on matching element(s)
  .invoke("dispatchEvent", args: ["turbo-ready:demo", {bubbles: true, detail: {...}}]) # set event options
  .flush
```

### Syntax Styles

It's possible to use symbols and [`snake_case`](https://en.wikipedia.org/wiki/Snake_case) when invoking DOM functionality.
It implicitly converts to [`camelCase`](https://en.wikipedia.org/wiki/Camel_case).

```ruby
turbo_stream.invoke :dispatch_event,
  args: ["turbo-ready:demo", {detail: {converts_to_camel_case: true}}]
```

Need to opt out? No problem... just disable it.

```ruby
turbo_stream.invoke :contrived_demo, camelize: false
```

### Extending Behavior

Add some new capability to the client.

```js
// JavaScript
import morphdom from 'morphdom'

window.MyNamespace = {
  morph: (from, to, options = {}) => {
    morphdom(document.querySelector(from), to, options)
  }
}
```

Then invoke it from the server.

```ruby
# Ruby
turbo_stream.invoke "MyNamespace.morph",
  args: [
    "#demo",
    "<div id='demo'><p>You've changed...</p></div>",
    {children_only: true}
  ]
```

### Implementation Details

There's basically one method to consider, `invoke` defined in the
[tag builder](https://github.com/hopsoft/turbo_ready/blob/main/lib/turbo_ready/tag_builder.rb).

```ruby
# Ruby
turbo_stream
  .invoke(method, args: [], selector: nil, camelize: true, id: nil)
#         |       |         |              |               |
#         |       |         |              |               |- Identifies this invocation (optional)
#         |       |         |              |
#         |       |         |              |- Should we camelize the JavaScript stuff? (optional)
#         |       |         |                 (allows us to write snake_case Ruby)
#         |       |         |
#         |       |         |- An CSS selector for the element(s) to target (optional)
#         |       |
#         |       |- The arguments to pass to the JavaScript method being invoked (optional)
#         |
#         |- The JavaScript method to invoke (can use dot notation)
```

📘 The JavaScript method will be invoked on all matching elements if a `selector` is present.

The `invoke` method creates a `turbo-stream` HTML element which wraps a JSON payload.
When this element enters the DOM, Turbo Streams executes the `invoke` action on the client with the JSON payload.

```ruby
turbo_stream.invoke "console.log", args: ["Hello World!"]
```

The code above emits this HTML markup.

```html
<turbo-stream action="invoke" target="DOM">
  <template>
    {"id":"644d6878-6b97-4b8e-9054-50f59abe57bb","method":"log","args":["Hello World!"],"receiver":"console","selector":null}
  </template>
</turbo-stream>
```

## Broadcasting

Sometimes you'll want to broadcast DOM invocations to multiple users.
**Here's how.**

```erb
<!-- app/views/posts/show.html.erb -->
<%= turbo_stream_from @post %>
<!--                  |
                      |- *streamables - model(s), string(s), etc...
-->
```

```ruby
# app/models/post.rb
class Post < ApplicationRecord
  after_save do
    # emit a message in the browser conosle for anyone subscribed to this post
    broadcast_invoke "console.log", args: ["Post was saved! #{to_gid.to_s}"]
  end
end
```

```ruby
# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def create
    @post = Post.find params[:id]

    if @post.update post_params
      # emit a message in the browser conosle for anyone subscribed to this post
      @post.broadcast_invoke "console.log", args: ["Post was saved! #{to_gid.to_s}"]

      # you can also broadcast directly from the channel
      Turbo::StreamsChannel.broadcast_invoke_to @post, "console.log",
        args: ["Post was saved! #{@post.to_gid.to_s}"]

      # or even handle the broadcast with a background job
      Turbo::StreamsChannel.broadcast_invoke_later_to @post, "console.log",
        args: ["Post was saved! #{@post.to_gid.to_s}"]
    end
  end
end
```

📘 Chaining is not currently supported when broadcasting.

### Configuration

You may want to change the the queue name for Turbo Stream jobs.

```ruby
# config/initializers/turbo_streams.rb
Turbo::Streams::BroadcastJob.queue_name = :turbo_streams
TurboReady::BroadcastInvokeJob.queue_name = :turbo_streams
```

## FAQ

- Isn't this just RJS?

  > No. But, perhaps it could be considered RJS's "modern" spirtual successor. 🤷‍♂️
  > Though it embraces JavaScript instead of inventing ways to avoid it.

- Does it use `eval`?

  > **No.** TurboReady can only invoke existing functions on the client.
  > It's not a carte blanche invitation to emit free-form JavaScript to be eval'd on the client.

## A Word of Caution

Manually orchestrating DOM activity gets tedious fast.
**Don't abuse this superpower!**

> With great power comes great responsibility. *-Uncle Ben*

This library is an extremely sharp tool. 🔪
Consider it a low-level building block that can be used to craft additional libraries
like [CableReady](https://github.com/stimulusreflex/cable_ready)
and [StimulusReflex](https://github.com/stimulusreflex/stimulus_reflex).

Restrict your usage to things that falls outside the purview of
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
