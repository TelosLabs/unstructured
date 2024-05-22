# frozen_string_literal: true

require_relative "unstructured/version"

module Unstructured
  autoload :Client, "unstructured/client"
  autoload :Collection, "unstructured/collection"
  autoload :Error, "unstructured/error"
  autoload :Object, "unstructured/object"

  autoload :ChunkCollection, "unstructured/chunk_collection"
  autoload :Chunk, "unstructured/objects/chunk"
end
