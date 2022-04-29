require 'uri'
require 'net/http'

# Сервис для запроса по uri
module FetchService
  def self.call(url, query_h = nil)
    uri = URI(url)
    uri.query = query_h.to_json if query_h

    res = Net::HTTP.get_response(uri)
    res.body if res.is_a?(Net::HTTPSuccess)
  end
end
