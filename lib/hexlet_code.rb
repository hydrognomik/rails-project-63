# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'renderer'

# HexletCode module
module HexletCode
  autoload :Tag, File.expand_path('./hexlet_code/tag', __dir__)

  def self.form_for(obj, opts = {}, &block)
    @fields = []
    @obj = obj
    action = opts[:url] || '#'
    opts.delete(:url)
    attrs = { action:, method: opts[:method] || 'post', **opts }
    block.call self if block_given?

    Renderer.render_html_form(attrs, @fields)
  end

  def self.input(name, args = {})
    as, = args.values_at(:as)
    args.delete(:as)
    value = @obj.public_send(name)
    @fields << ['label', { for: name, value: name.capitalize }]
    @fields << if as == :text
                 ['textarea', { name:, cols: 20, rows: 40, value:, **args }]
               else
                 ['input', { name:, type: 'text', value:, **args }]
               end
  end

  def self.submit(value = 'Save', **opts)
    @fields << ['input', { type: 'submit', value:, **opts }]
  end
end
