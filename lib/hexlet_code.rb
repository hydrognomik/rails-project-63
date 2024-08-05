# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode module
module HexletCode
  autoload :Tag, File.expand_path('./hexlet_code/tag', __dir__)
  autoload :Form, File.expand_path('./hexlet_code/form', __dir__)
  autoload :Renderer, File.expand_path('./hexlet_code/renderer', __dir__)

  def self.form_for(obj, opts = {}, &block)
    form = Form.new(obj)
    attrs = { action: opts.fetch(:url, '#'), method: 'post' }.merge(opts.except(:url))

    block.call form if block_given?

    Renderer.render_html_form(attrs, form.fields)
  end
end
