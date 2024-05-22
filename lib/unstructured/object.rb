# frozen_string_literal: true

require "ostruct"
module Unstructured
  class Object
    attr_reader :attributes, :raw_data

    def initialize(attributes)
      @raw_data = attributes
      @attributes = OpenStruct.new(attributes)
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      attribute = @attributes.send(method, *args, &block)
      attribute.is_a?(Hash) ? Object.new(attribute) : attribute
    end

    def respond_to_missing?(_method, _include_private = false)
      true
    end

    def to_h
      @raw_data
    end
  end
end
