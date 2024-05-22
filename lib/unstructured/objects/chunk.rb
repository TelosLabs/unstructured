# frozen_string_literal: true

module Unstructured
  class Chunk < Object
    def self.from_response(response)
      new(response)
    end
  end
end
