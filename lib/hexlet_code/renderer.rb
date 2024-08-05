# frozen_string_literal: true

module HexletCode
  class Input
    def initialize(attrs)
      @attrs = { type: 'text' }.merge(attrs)
    end

    def render
      input = HexletCode::Tag.build('input', @attrs)

      return input if @attrs[:type] == 'submit'

      label = HexletCode::Tag.build('label', { for: @attrs[:name] }) { @attrs[:name].capitalize }
      "#{label}#{input}"
    end
  end

  class Textarea
    def initialize(attrs)
      @attrs = { cols: 20, rows: 40 }.merge(attrs)
    end

    def render
      label = HexletCode::Tag.build('label', { for: @attrs[:name] }) { @attrs[:name].capitalize }
      textarea = HexletCode::Tag.build('textarea', **@attrs.except(:value)) { @attrs[:value] }
      "#{label}#{textarea}"
    end
  end

  INPUT_HASH = { input: Input, textarea: Textarea }.freeze

  # Renderer class
  class Renderer
    def self.render_html_form(attrs, fields)
      HexletCode::Tag.build('form', attrs) do
        fields.map do |(name, options)|
          next INPUT_HASH[name.to_sym].new(options).render if INPUT_HASH.key?(name.to_sym)

          HexletCode::Tag.build(name, options)
        end.join
      end
    end
  end
end
