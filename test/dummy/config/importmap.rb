# frozen_string_literal: true

pin "@alpinejs/morph", to: "@alpinejs--morph.js" # @3.13.5
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.2
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.2
pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.1.3
pin "alpinejs" # @3.13.5

# NOTE: Flowbite stops working if we allow Rails to vendor it
pin "flowbite", to: "https://ga.jspm.io/npm:flowbite@1.5.3/dist/flowbite.js"

# HACK: This allows us to pin a lib above Rails.root in the dummy app
#       It's goofy but works
FileUtils.rm_f Rails.root.join("app/javascript/@turbo-boost")
FileUtils.ln_s Rails.root.join("../../app/assets/builds/@turbo-boost"), Rails.root.join("app/javascript/@turbo-boost")
pin "@turbo-boost/streams", to: "@turbo-boost/streams.js"

pin "application", preload: true
