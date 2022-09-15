# frozen_string_literal: true

module TailwindHelper
  # Tailwind CSS defaults defined at: config/tailwind_defaults.yml
  # @return [Hash]
  def tailwind_defaults
    @tailwind_defaults ||= self.class.instance_variable_get(:@tailwind_defaults)
    @tailwind_defaults ||= begin
      defaults = YAML.safe_load(File.read(Rails.root.join("app/views/_tailwind.yml.erb")))
      self.class.instance_variable_set(:@tailwind_defaults, defaults) unless Rails.env.development?
      defaults
    end
  end

  # Builds a Tailwind CSS class string.
  #
  # NOTE: You may need to use the !important modifier when passing overrides.
  # SEE: https://v2.tailwindcss.com/docs/just-in-time-mode#built-in-important-modifier
  #
  # @param [String, Symbol] name A dot delimited key for an entry in: config/tailwind_defaults.yml
  # @param [Array<Object>] *overrides Value(s) that you'd pass to `token_list`
  # @return a string of Tailwind CSS classes
  def css(key, *overrides)
    default = tailwind_defaults.dig(*key.to_s.split("."))
    default = default["class"] if default.is_a?(Hash)
    token_list(default, *overrides).squish
  end
end
