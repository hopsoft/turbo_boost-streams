<p align="center">
  <h1 align="center">Welcome to TurboReady 👋</h1>
  <p align="center">
    <a href="http://blog.codinghorror.com/the-best-code-is-no-code-at-all/" target="_blank">
      <img alt="Lines of Code" src="https://img.shields.io/badge/lines_of_code-275-brightgreen.svg?style=flat" />
    </a>
  </p>
</p>

TurboReady extends [TurboStreams](https://turbo.hotwired.dev/reference/streams) to give you full control over the browser's [Document Object Model (DOM).](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)

**Thats right!**
You can `invoke` any DOM method on any DOM object *(including 3rd party libs)* with TurboStreams.

```ruby
turbo_stream.invoke "console.log", "Hello World!"
```

## Dependencies

- [`rails >=7.0`](https://rubygems.org/gems/rails)
- [`turbo-rails >=1.1`](https://rubygems.org/gems/turbo-rails) Ruby GEM
- [`@hotwired/turbo-rails >=7.2.0-beta.2`](https://yarnpkg.com/package/@hotwired/turbo-rails) JavaScript Package

## Installation

```ruby
bundle add "turbo_ready --version VERSION"
yarn add "turbo_ready@VERSION --exact"
```

> **IMPORTANT:** Be sure you use the same version for each libary.

## Setup

1. Create a Rails intializer and `patch` Turbo.

    ```ruby
    # config/initializers/turbo_ready.rb
    TurboReady.patch! # Adds TurboReady stream actions to Turbo
    ```
2. Import and intialize TurboReady in your JavaScript application.

    ```js
    // app/javascript/application.js
    import '@hotwired/turbo-rails'
    import TurboReady from '/bundle/ruby/3.1.0/gems/turbo_ready-0.1.0/app/assets/builds/turbo_ready.js'
    TurboReady.initialize(Turbo.StreamActions) // Adds TurboReady stream actions to Turbo
    ```

## Usage

Manipulate DOM from anywhere you can use TurboStreams.

```ruby
turbo_stream.invoke "setAttribute", "data-turbo-ready", true, selector: ".button"
```

You can even chain invocations. 🤯

```ruby
turbo_stream
  .invoke("document.body.insertAdjacentHTML", "afterbegin", "<h1>Hello World!</h1>") // dot notation
  .invoke("setAttribute", "data-turbo-ready", true, selector: ".button") // selector
  .invoke("classList.add", "turbo-ready", selector: "a") // dot notation + selector
  .flush // flush must be called when chaining invocations
```

You can use [dot notation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors#dot_notation) or a [selector](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll)... you can even use them together!

*Can I dispatch events?* You bet!

```ruby
turbo_stream
  .invoke("dispatchEvent", "turbo-ready:demo") // fires on window
  .invoke("dispatchEvent", "turbo-ready:demo", selector: "#my-element") // fires on matching element(s)
  .invoke("dispatchEvent", {bubbles: true, detail: {...}}) // set event options
  .flush
```

Wondering what else is possible?
[MDN has your back... learn about the DOM and web APIs here](https://developer.mozilla.org/en-US/docs/Web/API.)

## Advanced Usage

Want to add functionality with custom JavaScript? **Let's go...**

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

You can also use Ruby symbols and [snake case](https://en.wikipedia.org/wiki/Snake_case) when invoking DOM functionality.
*It will implicitly be converted to [camel case](https://en.wikipedia.org/wiki/Camel_case) for you.*

```ruby
turbo_stream
  .invoke(:animate, [{opacity: 0}, {opacity: 1}], 2000)
  .invoke(:dispatch_event, {detail: {converts_camel_case: true}})
  .flush
```

Need to opt out of this behavior? No problem... just disable it.

```ruby
turbo_stream.invoke :contrived_demo, camelize: false
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
