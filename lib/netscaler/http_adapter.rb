require 'netscaler/adapter'
require 'rest-client'
require 'json'

module Netscaler
  class HttpAdapter < Adapter
    def initialize(args)
      @site=RestClient::Resource.new(args[:hostname])
    end

    def post_no_body(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json#'application/json'

      post_data = prepare_payload(data)
      @site[url].post post_data, options
    end

    def post(part, data, args={})
      url = get_uri(part)
      options = prepare_options(args)
      options[:content_type] = :json#'application/json'

      post_data = prepare_payload(data)
      @site[url].post post_data, options do |response, request, result|
        return process_result(result, response)
      end
    end

    def get(part, args={})
      url = get_uri(part)
      options = prepare_options(args)

      @site[url].get options do |response, request, result|
        return process_result(result, response)
      end

    end
  end
end