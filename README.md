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
      <img alt="Lines of Code" src="https://img.shields.io/badge/loc-295-47d299.svg" />
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

**That's right!**
You can `invoke` any DOM method on the client with Turbo Streams.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Why boosted Streams?](#why-boosted-streams)
  - [Sponsors](#sponsors)
  - [Community](#community)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Usage](#usage)
    - [Method Chaining](#method-chaining)
    - [Event Dispatch](#event-dispatch)
    - [Morph](#morph)
    - [Morph Method](#morph-method)
    - [Syntax Styles](#syntax-styles)
    - [Extending Behavior](#extending-behavior)
    - [Implementation Details](#implementation-details)
    - [Broadcasting](#broadcasting)
      - [Background Job Queues](#background-job-queues)
  - [FAQ](#faq)
  - [A Word of Warning](#a-word-of-warning)
  - [Developing](#developing)
      - [Notable Files](#notable-files)
  - [Deploying](#deploying)
      - [Notable Files](#notable-files-1)
      - [How to Deploy](#how-to-deploy)
  - [Releasing](#releasing)
  - [About TurboBoost](#about-turboboost)
  - [License](#license)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Why boosted Streams?

Turbo Streams [intentionally restrict](https://turbo.hotwired.dev/handbook/streams#but-what-about-running-javascript%3F)
official actions to CRUD-related activity.
These [official actions](https://turbo.hotwired.dev/reference/streams#the-seven-actions) work well for a considerable number of use cases.
*We recommend that you push Turbo Streams as far as possible before reaching for __boosted streams__.*

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

## Community

Come join the party with over 2200+ like-minded friendly Rails/Hotwire enthusiasts on our [Discord server](https://discord.gg/stimulus-reflex).

## Dependencies

- [rails](https://rubygems.org/gems/rails) `>= 6.1`
- [turbo-rails](https://rubygems.org/gems/turbo-rails) `>= 1.1`
- [@hotwired/turbo-rails](https://www.npmjs.com/package/@hotwired/turbo-rails) `>= 7.2`

## Installation

Be sure to install the same version for each library.

```sh
bundle add "turbo_boost-streams --version VERSION"
npm install "@turbo-boost/streams@VERSION"
```

## Setup

Import and initialize Turbo Boost Streams in your application.

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

### Morph

You can morph elements with the `morph` method.

```ruby
turbo_stream.invoke(:morph, args: [render("path/to/partial")], selector: "#my-element")
```

> [!NOTE]
> TurboBoost Streams uses [Idiomorph](https://github.com/bigskysoftware/idiomorph) for morphing.

The following options are used to morph elements.

```js
{
  morphStyle: 'outerHTML',
  ignoreActiveValue: true,
  head: { style: 'merge' },
  callbacks: { beforeNodeMorphed: (oldNode, _) => ... }
}
```

> [!TIP]
> The callbacks honor the `data-turbo-permanent` attribute and is aware of the [Trix](https://trix-editor.org/) editor.

### Morph Method

The morph method is also exported to the `TurboBoost.Streams` global and is available for client side morphing.

```js
TurboBoost.Streams.morph.method // → function(targetNode, htmlString, options = {})
```

You can also override the `morph` method if desired.

```js
TurboBoost.Streams.morph.method = (targetNode, htmlString, options = {}) => {
  // your custom implementation
}
```

It also support adding a delay before morphing is performed.

```js
TurboBoost.Streams.morph.delay = 50 // → 50ms
```

> [!TIP]
> Complex test suites may require a delay to ensure the DOM is ready before morphing.

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

window.MyNamespace = { coolStuff: (arg) => { ... } }
```

```ruby
# Ruby on the server
turbo_stream.invoke "MyNamespace.coolStuff", args: ["Hello World!"]
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
        # emit a message in the browser console for anyone subscribed to this post
        broadcast_invoke "console.log", args: ["Post was saved! #{to_gid}"]

        # broadcast with a background job
        broadcast_invoke_later "console.log", args: ["Post was saved! #{to_gid}"]
      end
    end
    ```

    ```ruby
    # app/controllers/posts_controller.rb
    class PostsController < ApplicationController
      def create
        @post = Post.find params[:id]

        if @post.update post_params
          # emit a message in the browser console for anyone subscribed to this post
          @post.broadcast_invoke "console.log", args: ["Post was saved! #{@post.to_gid}"]

          # broadcast with a background job
          @post.broadcast_invoke_later "console.log", args: ["Post was saved! #{@postto_gid}"]

          # you can also broadcast directly from the channel
          Turbo::StreamsChannel.broadcast_invoke_to @post, "console.log",
            args: ["Post was saved! #{@post.to_gid}"]

          # broadcast with a background job
          Turbo::StreamsChannel.broadcast_invoke_later_to @post, "console.log",
            args: ["Post was saved! #{@post.to_gid}"]
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

  > No. But, perhaps it could be considered RJS's "modern" spiritual successor. 🤷‍♂️
  > Though it embraces JavaScript instead of trying to avoid it.

- Does it use `eval`?

  > **No.** The `invoke` stream can only execute existing functions on the client.
  > It's not a carte blanche invitation to emit free-form JavaScript to be evaluated on the client.

## A Word of Warning

TurboBoost Streams is a foundational tool designed to help you build modern, maintainable, and scalable reactive web apps with Hotwire.
It allows you to break free from the strict CRUD/REST conventions that Rails and Hotwire wisely encourage.
You should consider boosted streams a substrate for building additional libraries and abstractions.

*Please don't use TurboBoost Streams to manually orchestrate micro DOM updates (from the server).
Such techniques are what gave rise to Full Stack Frontend and sent the industry on a decade-long journey of complexity and frustration.*

## Developing

This project supports a fully Dockerized development experience.

1. Simply run the following commands to get started.

    ```sh
    git clone -o github https://github.com/hopsoft/turbo_boost-streams.git
    cd turbo_boost-streams
    ```

    ```sh
    docker compose up -d # start the environment (will take a few minutes on 1st run)
    docker exec -it turbo_boost-streams-web rake # run the test suite
    open http://localhost:3000 # open the `test/dummy` app in a browser
    ```

    And, if you're using the [containers gem (WIP)](https://github.com/hopsoft/containers).

    ```sh
    containers up # start the environment (will take a few minutes on 1st run)
    containers rake # run the test suite
    open http://localhost:3000 # open the `test/dummy` app in a browser
    ```

1. Edit files using your preferred tools on the host machine.

1. That's it!

####  Notable Files

- [Dockerfile](https://github.com/hopsoft/turbo_boost-streams/blob/main/Dockerfile)
- [docker-compose.yml](https://github.com/hopsoft/turbo_boost-streams/blob/main/docker-compose.yml)
- [bin/docker/run/local](https://github.com/hopsoft/turbo_boost-streams/blob/main/bin/docker/run/local)

## Deploying

This project supports Dockerized deployment via the same configuration used for development,
and... it actually runs the [`test/dummy`](https://github.com/hopsoft/turbo_boost-streams/tree/main/test/dummy) application in "production". 🤯

The `test/dummy` app serves the following purposes.

- Test app for the Rails engine
- Documentation and marketing site with interactive demos

You can [__see it in action__ here.](https://hopsoft.io/@turbo-boost/streams)
_How's that for innovative simplicity?_

####  Notable Files

- [Dockerfile](https://github.com/hopsoft/turbo_boost-streams/blob/main/Dockerfile)
- [fly.toml](https://github.com/hopsoft/turbo_boost-streams/blob/main/fly.toml)
- [bin/docker/run/remote](https://github.com/hopsoft/turbo_boost-streams/blob/main/bin/docker/run/remote)

#### How to Deploy

```sh
fly deploy
```

## Releasing

> [!TIP]
> Run these commands on the host machine _(i.e. not inside the dev container)_

1. Run `npm update` and `bundle update` to pick up the latest dependencies
1. Update the version number consistently in the following files:
   * `lib/turbo_boost/streams/version.rb` - pre-release versions should use `.preN`
   * `app/javascript/version.js` - pre-release versions use `-preN`
   * `package.json` - pre-release versions use `-preN`
1. Run `bin/standardize`
1. Run `rake build`
1. Run `npm run build`
1. Commit and push any changes to GitHub
1. Run `rake release`
1. Run `npm publish --access public`
1. Create a new release on GitHub ([here](https://github.com/hopsoft/turbo_boost-streams/releases)) and generate the changelog for the stable release for it

## About TurboBoost

TurboBoost is a suite of libraries that enhance Rails, Hotwire, and Turbo... making them even more powerful and boosting your productivity.
Be sure to check out all of the various libraries.

- [Streams](https://github.com/hopsoft/turbo_boost-streams)
- [Commands](https://github.com/hopsoft/turbo_boost-commands)
- [Elements](https://github.com/hopsoft/turbo_boost-elements)
- [Devtools](https://github.com/hopsoft/turbo_boost-devtools)
- Coming soon...

## License

These libraries are available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
