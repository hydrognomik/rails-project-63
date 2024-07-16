# frozen_string_literal: true

# #module Tag
module HexletCode::Tag
  def self.build(name, options = {})
    attrs = attributes(options)

    if name == "br"
      return "<#{name}>"
    end

    input = if %w[image input].include? name
      "<#{name}#{attrs}>"
    else
      "<#{name}#{attrs}>#{yield if block_given?}</#{name}>"
    end

    if %w[input textarea].include?(name) && options[:type] != "submit"
      "<label for=\"#{options[:name]}\">#{options[:name].capitalize}</label>#{input}"
    else
      input
    end
  end

  def self.attributes(attrs)
    attrs.each_with_object([]) do |(k, v), arr|
      arr << " #{k}=\"#{v}\""
    end.join("")
  end
end
