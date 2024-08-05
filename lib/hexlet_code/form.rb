# frozen_string_literal: true

module HexletCode
  # Form class
  class Form
    attr_reader :fields

    def initialize(obj)
      @obj = obj
      @fields = []
    end

    def input(name, attrs = {})
      value = @obj.public_send(name)
      field_name = attrs[:as] == :text ? 'textarea' : 'input'
      @fields << [field_name, { name:, value:, **attrs.except(:as) }]
    end

    def submit(value = 'Save', **attrs)
      @fields << ['input', { type: 'submit', value:, **attrs }]
    end
  end
end
