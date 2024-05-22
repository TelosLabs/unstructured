# frozen_string_literal: true

require "faraday"
require "faraday/multipart"
require "marcel"

module Unstructured
  class Client
    SERVER_URL = "https://api.unstructured.io"

    attr_reader :server_url, :api_key_auth, :adapter

    def initialize(server_url: nil, api_key_auth: nil, adapter: Faraday.default_adapter, stubs: nil)
      @server_url = server_url || SERVER_URL
      @api_key_auth = api_key_auth
      @adapter = adapter
      @stubs = stubs
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = server_url
        conn.request :multipart
        conn.response :json, content_type: "application/json"
        conn.adapter adapter, @stubs
        conn.headers["unstructured-api-key"] = api_key_auth if api_key_auth
      end
    end

    def partition(file_path, params = {}, headers: {})
      ChunkCollection.from_response handle_response(connection.post(
                                                      "/general/v0/general",
                                                      default_params.merge(params).merge({
                                                                                           files: files(file_path)
                                                                                         }),
                                                      headers
                                                    ))
    end

    def inspect
      "#<#{self.class.name} server_url=#{server_url.inspect}>"
    end

    private

    def files(file_path)
      mime_type = Marcel::MimeType.for Pathname.new(file_path)
      Faraday::UploadIO.new(file_path, mime_type)
    end

    def default_params
      {
        strategy: "fast",
        hi_res_model_name: "yolox",
        pdf_infer_table_structure: true,
        chunking_strategy: "by_title"
      }
    end

    def handle_response(response)
      message = response
      case response.status
      when 401
        raise Error, message
      when 404
        raise Error, message
      when 422
        raise Error, message
      when 500
        raise Error, message
      when 200..299
        response.body
      else
        raise Error, message
      end
    end
  end
end
