require 'uri'
require 'net/http'

# Сервис для запроса по uri
module FetchService
  def self.call(url, query_h = nil)
    uri = URI.(url)
    uri.params = query_h if query_h

    res = Net::HTTP.get_respone(uri)
    res.body if res.is_a?(Net::HTTPSuccess)
  end
end