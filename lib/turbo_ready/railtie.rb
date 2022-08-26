# frozen_string_literal: true

module TurboReady
  class Railtie < ::Rails::Railtie
    initializer "turbo_ready.patch" do
      ::ActiveSupport.on_load(:action_cable) do
        # Adds TurboReady stream actions to Turbo
        TurboReady.patch!
      end
    end
  end
end
