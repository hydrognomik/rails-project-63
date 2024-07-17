# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode module
module HexletCode
  class Error < StandardError; end

  autoload :Tag, File.expand_path('./tag', __dir__)

  def self.form_for(obj, opts = {}, &block)
    @fields = []
    @obj = obj
    attrs = { action: opts[:url] || '#', method: opts[:method] || 'post' }
    attrs[:class] = opts[:class] if opts[:class]
    block.call self if block_given?
    "<form#{HexletCode::Tag.attributes(attrs)}>#{@fields.join}</form>"
  end

  def self.input(name, args = {})
    as, = args.values_at(:as)
    args.delete(:as)
    value = @obj.public_send(name)
    @fields << if as == :text
                 Tag.build('textarea', { name:, cols: 20, rows: 40, **args }) { value }
               else
                 Tag.build('input', { name:, type: 'text', value:, **args })
               end
  end

  def self.submit(value = 'Save')
    @fields << Tag.build('input', { type: 'submit', value: })
  end
end
