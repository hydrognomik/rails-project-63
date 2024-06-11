# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode module
module HexletCode
  class Error < StandardError; end

  autoload :Tag, File.expand_path("./tag", __dir__)

  def self.form_for(obj, opts = {}, &block)
    @@fields = []
    @@obj = obj
    block.call self
    "<form action=\"#{opts[:url] || "#"}\" method=\"post\">#{@@fields.join("")}</form>"
  end

  def self.input(name, args = {})
    as, = args.values_at(:as)
    args.delete(:as)
    value = @@obj.public_send(name)
    if as == :text
      @@fields << Tag.build("textarea", { name:, cols: 20, rows: 40, **args }) { value }
    else
      @@fields << Tag.build("input", { name:, type: "text", value:, **args })
    end
  end
end
