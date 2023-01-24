<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://ik.imagekit.io/hopsoft/turbo-boost-logo-dark-bg_o_f0bVskz.webp?ik-sdk-version=javascript-1.4.3&updatedAt=1671722004391">
    <img height="60" src="https://ik.imagekit.io/hopsoft/turbo-boost-logo_zHiiimlvT.webp?ik-sdk-version=javascript-1.4.3&updatedAt=1671722004342" />
  </picture>
  <h1 align="center">
    Welcome to TurboBoost Streams 👋
  </h1>
  <p align="center">
    <a href="http://blog.codinghorror.com/the-best-code-is-no-code-at-all/">
      <img alt="Lines of Code" src="https://img.shields.io/badge/loc-243-47d299.svg" />
    </a>
    <a href="https://codeclimate.com/github/hopsoft/turbo_boost-streams/maintainability">
      <img src="https://api.codeclimate.com/v1/badges/a6671f4294ec0f21f732/maintainability" />
    </a>
    <a href="https://rubygems.org/gems/turbo_boost-streams">
      <img alt="GEM Version" src="https://img.shields.io/gem/v/turbo_boost-streams?color=168AFE&include_prereleases&logo=ruby&logoColor=FE1616">
    </a>
    <a href="https://rubygems.org/gems/turbo_boost-streams">
      <img alt="GEM Downloads" src="https://img.shields.io/gem/dt/turbo_boost-streams?color=168AFE&logo=ruby&logoColor=FE1616">
    </a>
    <a href="https://github.com/testdouble/standard">
      <img alt="Ruby Style" src="https://img.shields.io/badge/style-standard-168AFE?logo=ruby&logoColor=FE1616" />
    </a>
    <a href="https://www.npmjs.com/package/@turbo-boost/streams">
      <img alt="NPM Version" src="https://img.shields.io/npm/v/@turbo-boost/streams?color=168AFE&logo=npm">
    </a>
    <a href="https://www.npmjs.com/package/@turbo-boost/streams">
      <img alt="NPM Downloads" src="https://img.shields.io/npm/dm/@turbo-boost/streams?color=168AFE&logo=npm">
    </a>
    <a href="https://bundlephobia.com/package/@turbo-boost/streams@">
      <img alt="NPM Bundle Size" src="https://img.shields.io/bundlephobia/minzip/@turbo-boost/streams?label=bundle%20size&logo=npm&color=47d299">
    </a>
    <a href="https://github.com/sheerun/prettier-standard">
      <img alt="JavaScript Style" src="https://img.shields.io/badge/style-prettier--standard-168AFE?logo=javascript&logoColor=f4e137" />
    </a>
    <a href="https://github.com/hopsoft/turbo_boost-streams/actions/workflows/tests.yml">
      <img alt="Tests" src="https://github.com/hopsoft/turbo_boost-streams/actions/workflows/tests.yml/badge.svg" />
    </a>
    <a href="https://github.com/hopsoft/turbo_boost-streams/discussions" target="_blank">
      <img alt="GitHub Discussions" src="https://img.shields.io/github/discussions/hopsoft/turbo_boost-streams?color=168AFE&logo=github">
    </a>
    <a href="https://discord.gg/stimulus-reflex">
      <img alt="Discord Community" src="https://img.shields.io/discord/629472241427415060?color=8892F6&label=discord&logo=discord&logoColor=8892F6">
    </a>
    <a href="https://github.com/sponsors/hopsoft">
      <img alt="Sponsors" src="https://img.shields.io/github/sponsors/hopsoft?color=eb4aaa&logo=GitHub%20Sponsors" />
    </a>
    <br>
    <a href="https://ruby.social/@hopsoft">
      <img alt="Ruby.Social Follow" src="https://img.shields.io/mastodon/follow/000008274?domain=https%3A%2F%2Fruby.social&label=%40hopsoft&style=social">
    </a>
    <a href="https://twitter.com/hopsoft">
      <img alt="Twitter Follow" src="https://img.shields.io/twitter/url?label=%40hopsoft&style=social&url=https%3A%2F%2Ftwitter.com%2Fhopsoft">
    </a>
  </p>
</p>

**TurboBoost Streams extends [Turbo Streams](https://turbo.hotwired.dev/reference/streams) to give you full control of the
browser's [Document Object Model (DOM).](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)**

```ruby
turbo_stream.invoke "console.log", args: ["Hello World!"]
```

**Thats right!**
You can `invoke` any DOM method on the client with Turbo Streams.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Why boosted Streams?](#why-boosted-streams)
  - [Sponsors](#sponsors)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Usage](#usage)
    - [Method Chaining](#method-chaining)
    - [Event Dispatch](#event-dispatch)
    - [Syntax Styles](#syntax-styles)
    - [Extending Behavior](#extending-behavior)
    - [Implementation Details](#implementation-details)
    - [Broadcasting](#broadcasting)
      - [Background Job Queues](#background-job-queues)
  - [FAQ](#faq)
  - [A Word of Warning](#a-word-of-warning)
  - [Community](#community)
    - [Discussions](#discussions)
    - [Twitter](#twitter)
  - [Releasing](#releasing)
  - [About TurboBoost](#about-turboboost)
  - [License](#license)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Why boosted Streams?

Turbo Streams [intentionally restrict](https://turbo.hotwired.dev/handbook/streams#but-what-about-running-javascript%3F)
official actions to CRUD related activity.
These [official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions) work well for a considerable number of use cases.
*Try pushing Turbo Streams as far as possible before reaching for boosted streams.*

If you find that CRUD isn't enough, boosted streams are there to handle pretty much everything else.

## Sponsors

<p align="center">
  <em>Proudly sponsored by</em>
</p>
<p align="center">
  <a href="https://www.clickfunnels.com?utm_source=hopsoft&utm_medium=open-source&utm_campaign=turbo_boost-streams">
    <img src="https://images.clickfunnel.com/uploads/digital_asset/file/176632/clickfunnels-dark-logo.svg" width="575" />
  </a>
</p>

## Dependencies

- [rails](https://rubygems.org/gems/rails) `>=6.1`
- [turbo-rails](https://rubygems.org/gems/turbo-rails) `>=1.1`
- [@hotwired/turbo](https://yarnpkg.com/package/@hotwired/turbo) `>=7.2.0`
- [@hotwired/turbo-rails](https://yarnpkg.com/package/@hotwired/turbo-rails) `>=7.2.0`

## Installation

Be sure to install the same version for each libary.

```sh
bundle add "turbo_boost-streams --version VERSION"
yarn add "@turbo-boost/streams@VERSION --exact"
```

## Setup

Import and intialize Turbo Boost Streams in your application.

```diff
# Gemfile
gem "turbo-rails", ">= 1.1", "< 2"
+gem "turbo_boost-streams", "~> VERSION"
```

```diff
# package.json
"dependencies": {
  "@hotwired/turbo-rails": ">=7.2",
+  "@turbo-boost/streams": "^VERSION"
```

```diff
# app/javascript/application.js
import '@hotwired/turbo-rails'
+import '@turbo-boost/streams'
```

## Usage

Manipulate the DOM from anywhere you use official [Turbo Streams](https://turbo.hotwired.dev/handbook/streams#integration-with-server-side-frameworks).
The possibilities are endless.
[Learn more about the DOM at MDN.](https://developer.mozilla.org/en-US/docs/Web/API.)

```ruby
turbo_stream.invoke "console.log", args: ["Hello World!"]
```

### Method Chaining

You can use [dot notation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors#dot_notation)
or [selectors](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll) and even combine them!

```ruby
turbo_stream
  .invoke("document.body.insertAdjacentHTML", args: ["afterbegin", "<h1>Hello World!</h1>"]) # dot notation
  .invoke("setAttribute", args: ["data-turbo-ready", true], selector: ".button") # selector
  .invoke("classList.add", args: ["turbo-ready"], selector: "a") # dot notation + selector
```

### Event Dispatch

It's possible to fire events on `window`, `document`, and element(s).

```ruby
turbo_stream
  .invoke(:dispatch_event, args: ["turbo-ready:demo"]) # fires on window
  .invoke("document.dispatchEvent", args: ["turbo-ready:demo"]) # fires on document
  .invoke(:dispatch_event, args: ["turbo-ready:demo"], selector: "#my-element") # fires on matching element(s)
  .invoke(:dispatch_event, args: ["turbo-ready:demo", {bubbles: true, detail: {...}}]) # set event options
```

### Syntax Styles

You can use [`snake_case`](https://en.wikipedia.org/wiki/Snake_case) when invoking DOM functionality.
It will implicitly convert to [`camelCase`](https://en.wikipedia.org/wiki/Camel_case).

```ruby
turbo_stream.invoke :event,
  args: ["turbo-ready:demo", {detail: {converts_to_camel_case: true}}]
```

Need to opt-out? No problem... just disable it.

```ruby
turbo_stream.invoke :contrived_demo, camelize: false
```

### Extending Behavior

If you add new capabilities to the browser, you can control them from the server.

```js
// JavaScript on the client
import morphdom from 'morphdom'

window.MyNamespace = {
  morph: (from, to, options = {}) => {
    morphdom(document.querySelector(from), to, options)
  }
}
```

```ruby
# Ruby on the server
turbo_stream.invoke "MyNamespace.morph",
  args: [
    "#demo",
    "<div id='demo'><p>You've changed...</p></div>",
    {children_only: true}
  ]
```

### Implementation Details

There's basically one method to learn... `invoke`

```ruby
# Ruby
turbo_stream
  .invoke(method, args: [], selector: nil, camelize: true, id: nil)
#         |       |         |              |               |
#         |       |         |              |               |- Identifies this invocation (optional)
#         |       |         |              |
#         |       |         |              |- Should we camelize the JavaScript stuff? (optional)
#         |       |         |                 (allows us to write snake_case in Ruby)
#         |       |         |
#         |       |         |- A CSS selector for the element(s) to target (optional)
#         |       |
#         |       |- The arguments to pass to the JavaScript method (optional)
#         |
#         |- The JavaScript method to invoke (can use dot notation)
```

> 📘 **NOTE:** The method will be invoked on all matching elements if a `selector` is present.

The following Ruby code,

```ruby
turbo_stream.invoke "console.log", args: ["Hello World!"], id: "123ABC"
```

emits this HTML markup.

```html
<turbo-stream action="invoke" target="DOM">
  <template>{"id":"123ABC","receiver":"console","method":"log","args":["Hello World!"]}</template>
</turbo-stream>
```

When this element enters the DOM,
Turbo Streams automatically executes `invoke` on the client with the template's JSON payload and then removes the element from the DOM.

### Broadcasting

You can also broadcast DOM invocations to subscribed users.

1. First, setup the stream subscription.

    ```erb
    <!-- app/views/posts/show.html.erb -->
    <%= turbo_stream_from @post %>
    <!--                  |
                          |- *streamables - model(s), string(s), etc...
    -->
    ```

2. Then, broadcast to the subscription.

    ```ruby
    # app/models/post.rb
    class Post < ApplicationRecord
      after_save do
        # emit a message in the browser conosle for anyone subscribed to this post
        broadcast_invoke "console.log", args: ["Post was saved! #{to_gid.to_s}"]

        # broadcast with a background job
        broadcast_invoke_later "console.log", args: ["Post was saved! #{to_gid.to_s}"]
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

          # broadcast with a background job
          @post.broadcast_invoke_later "console.log", args: ["Post was saved! #{to_gid.to_s}"]

          # you can also broadcast directly from the channel
          Turbo::StreamsChannel.broadcast_invoke_to @post, "console.log",
            args: ["Post was saved! #{@post.to_gid.to_s}"]

          # broadcast with a background job
          Turbo::StreamsChannel.broadcast_invoke_later_to @post, "console.log",
            args: ["Post was saved! #{@post.to_gid.to_s}"]
        end
      end
    end
    ```

> 📘 **NOTE:** [Method Chaining](#method-chaining) is not currently supported when broadcasting.

#### Background Job Queues

You may want to change the queue name for Turbo Stream background jobs in order to isolate, prioritize, and scale the workers independently.

```ruby
# config/initializers/turbo_streams.rb
Turbo::Streams::BroadcastJob.queue_name = :turbo_streams
TurboBoost::Streams::BroadcastInvokeJob.queue_name = :turbo_streams
```

## FAQ

- Isn't this just RJS?

  > No. But, perhaps it could be considered RJS's "modern" spirtual successor. 🤷‍♂️
  > Though it embraces JavaScript instead of trying to avoid it.

- Does it use `eval`?

  > **No.** The `invoke` stream can only execute existing functions on the client.
  > It's not a carte blanche invitation to emit free-form JavaScript to be evaluated on the client.

## A Word of Warning

TurboBoost Streams is a foundational tool designed to help you build modern, maintainable, and scalable reactive web apps with Hotwire.
It allows you to break free from the strict CRUD/REST conventions that Rails and Hotwire wisely encourage.
You should consider boosted streams a substrate for building additional libraries and abstractions.

*Please don't use TurboBoost Streams to manually orchestrate micro DOM updates (from the server).
Such techniques are what gave rise to Full Stack Frontend and sent the industry on a decade long journey of complexity and frustration.*

## Community

### Discussions

Feel free to add to the conversation here on [GitHub Discussions](https://github.com/hopsoft/turbo_boost-streams/discussions).

### Twitter

Connect with the core team on Twitter.

<a href="https://twitter.com/hopsoft" target="_blank">
  <img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/hopsoft?logo=twitter&style=social">
</a>

## Releasing

1. Run `yarn` and `bundle` to pick up the latest
1. Bump version number at `lib/turbo_boost-streams/version.rb`. Pre-release versions use `.preN`
1. Run `rake build` and `yarn build`
1. Run `bin/standardize`
1. Commit and push changes to GitHub
1. Run `rake release`
1. Run `yarn publish --no-git-tag-version --access public`
1. Yarn will prompt you for the new version. Pre-release versions use `-preN`
1. Commit and push changes to GitHub
1. Create a new release on GitHub ([here](https://github.com/hopsoft/turbo_boost-streams/releases)) and generate the changelog for the stable release for it

## About TurboBoost

TurboBoost is a suite of projects that enhance Rails and Hotwire to make building server rendered reactive applications simpler and more powerful.
Be sure to check out all of the various the libraries.

- [Streams](https://github.com/hopsoft/turbo_boost-streams)
- [Commands](https://github.com/hopsoft/turbo_boost-commands)
- Coming soon...

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
