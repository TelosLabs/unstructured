# frozen_string_literal: true

module Unstructured
  class Collection
    include Enumerable

    attr_reader :data, :total

    def self.from_response(response)
      new(
        data: response.map { |attrs| type.new(attrs) },
        raw_data: response,
        total: response.length
      )
    end

    def initialize(data:, raw_data:, total:)
      @data = data
      @raw_data = raw_data
      @total = total
    end

    def to_h
      @raw_data
    end

    def each(&block)
      return to_enum(__method__) { @data.size } unless block_given?

      @data.each(&block)
    end

    def self.type
      raise NotImplementedError
    end
  end
end
