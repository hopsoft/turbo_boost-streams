# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

target = File.expand_path(Rails.root.join("../../app/assets/builds/@turbo-boost"))
link = File.expand_path(Rails.root.join("app/javascript/@turbo-boost"))
FileUtils.rm_r link, force: true, verbose: true if File.exist?(link) && !File.symlink?(link)
FileUtils.ln_s target, link, force: true, verbose: true unless File.exist?(link)

pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.2.4/dist/turbo.es2017-esm.js"
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.2.4/app/javascript/turbo/index.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.4/src/index.js"
pin "flowbite", to: "https://ga.jspm.io/npm:flowbite@1.5.3/dist/flowbite.js"
pin "@turbo-boost/streams", to: "@turbo-boost/streams.js"
pin "application", preload: true
