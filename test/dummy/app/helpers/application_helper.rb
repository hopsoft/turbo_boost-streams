# frozen_string_literal: true

module ApplicationHelper
  # Renders a component partial defined in: app/views/components
  #
  # @param [String, Symbol] name The name of the partial
  # @param [Hash] locals Local variables to assign to the partial
  # @option opts [String] :html An HTML string to use (mutually exclusive with passing a block)
  # @yield [String] Optional block that returns a string
  #
  # @return [String] The rendered HTML
  def render_component(name, locals = {}, &block)
    partial = "components/#{name}"
    return render(partial, locals, &block) if block
    render(partial, locals.except(:html)) { locals[:html] }
  end

  alias_method :ui, :render_component
end
