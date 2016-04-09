require 'json'
require 'rest-client'

class REST
  attr_reader :result, :response

  def to_query(hash)
    hash.to_a
        .map { |param, value| value.is_a?(Array) ? value.map { |v| [param, v] } : [[param, value]] }
        .flatten(1)
        .map { |param, value| [param, URI.escape(value.to_s)] }
        .map { |param, value| "#{param}=#{value}" }
        .join '&'
  end

  def initialize(host)
    @host = host
    @cookies = {}
  end

  def get path, params={}, headers={}
    query_string = to_query params

    url = File.join(@host, path)
    if query_string.length > 0
        url = url + "?" + query_string
    end

    response = RestClient.get url, {cookies: @cookies}.merge(headers)

    @cookies.merge! response.cookies
    @result = response.body
    @response = response
  end

  def post endpoint, path, data={}, headers={}
    options = {cookies: @cookies}.merge headers
    url = host + File.join(@host, path)

    response = RestClient.post url, data, options

    @cookies.merge! response.cookies
    @result = response.body
    @response = response
  end

  def post_json endpoint, path, data={}, headers={}
    post endpoint, path, data.to_json, headers.merge('Content-Type' => 'application/json')
  end

  def result_as_json
    JSON.parse(@result.to_s, quirks_mode: true, symbolize_names: true)
  end

  def set_proxy proxy
    RestClient.proxy = proxy
  end
end
