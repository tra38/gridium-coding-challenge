require 'net/http'

class GridiumData
  attr_reader :url
  def initialize(url)
    @url = URI.parse(url)
  end

  def get_json
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, :use_ssl => true) {|http|
      http.request(req)
    }
    res.body
  end
end