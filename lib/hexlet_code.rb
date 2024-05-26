# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode module
module HexletCode
  class Error < StandardError; end

  # Tag classname
  class Tag
    def self.build(name, attrs)
      attributes = []
      attrs.each do |k, v|
        attributes << "#{k}='#{v}'"
      end
      if %w[br image input].include? name
        "<#{name} #{attributes.join(" ")} />"
      else
        "<#{name}#{attributes.join(" ")}>#{yield if block_given?}</#{name}>"
      end
    end
  end

  def self.form_for(_, opts = {})
    "<form action='#{opts[:url] || "#"}' method='post'></form>"
  end
end
