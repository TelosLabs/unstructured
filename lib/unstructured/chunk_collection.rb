# frozen_string_literal: true

module Unstructured
  class ChunkCollection < Collection
    def self.type
      Unstructured::Chunk
    end
  end
end
