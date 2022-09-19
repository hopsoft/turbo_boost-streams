# frozen_string_literal: true

require "rouge"

module CodeHelper
  def read_source(path)
    File.read Rails.root.join(path)
  end

  def render_source(source, language:)
    formatter = Rouge::Formatters::HTML.new

    lexer = case language
    when :erb then Rouge::Lexers::ERB.new
    when :ruby then Rouge::Lexers::Ruby.new
    when :javascript then Rouge::Lexers::Javascript.new
    end

    formatter.format(lexer.lex(source)).html_safe
  end
end
