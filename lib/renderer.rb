# frozen_string_literal: true

class Renderer
  def self.render_html_form(attrs, fields)
    HexletCode::Tag.build('form', attrs) do
      fields.map do |(name, options)|
        block = nil
        if %w[label textarea].include?(name)
          block = options[:value].to_s
          options.delete(:value)
        end
        HexletCode::Tag.build(name, options) { block }
      end.join
    end
  end
end
