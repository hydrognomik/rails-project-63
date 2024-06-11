# frozen_string_literal: true

# #module Tag
module HexletCode::Tag
  def self.build(name, options = {})
    attrs = attributes(options)

    if name == "br"
      "<#{name}>"
    elsif %w[image input].include? name
      "<#{name}#{attrs}>"
    else
      "<#{name}#{attrs}>#{yield if block_given?}</#{name}>"
    end
  end

  def self.attributes(attrs)
    attrs.each_with_object([]) do |(k, v), arr|
      arr << " #{k}=\"#{v}\""
    end.join("")
  end
end
