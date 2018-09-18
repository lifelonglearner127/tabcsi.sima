# frozen_string_literal: true

module MarkdownHelper
  def parse_markdown(text)
    Kramdown::Document.new(text).to_html
  end
end
