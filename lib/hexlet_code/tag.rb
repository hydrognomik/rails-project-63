# frozen_string_literal: true

module HexletCode
  # module Tag
  module Tag
    def self.build(name, options = {})
      attrs = attributes(options)

      return "<#{name} #{attrs}>" if %w[img input br].include?(name)

      "<#{name} #{attrs}>#{yield if block_given?}</#{name}>"
    end

    def self.attributes(attrs)
      attrs.map do |(k, v)|
        "#{k}=\"#{v}\""
      end.join(' ')
    end
  end
end
