# frozen_string_literal: true

module HexletCode
  # module Tag
  module Tag
    def self.build(name, options = {})
      attrs = attributes(options)

      input = if %w[image input br].include?(name)
                "<#{name}#{attrs}>"
              else
                "<#{name}#{attrs}>#{yield if block_given?}</#{name}>"
              end

      if %w[input textarea].include?(name) && options[:type] != 'submit'
        return "<label for=\"#{options[:name]}\">#{options[:name].capitalize}</label>#{input}"
      end

      input
    end

    def self.attributes(attrs)
      attrs.each_with_object([]) do |(k, v), arr|
        arr << " #{k}=\"#{v}\""
      end.join('')
    end
  end
end
