module PostService
  def self.call(url, body_h = nil)
    HTTParty.post(
      url,
      headers: { 'Content-Type' => 'application/json' },
      body: body_h.to_json
    )
  end
end
