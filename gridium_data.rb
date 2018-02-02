require 'net/http'
require 'json'

class GridiumData
  attr_reader :url, :rows
  def initialize(url)
    @url = URI.parse(url)
    json = JSON.parse(get_json)
    @rows = json["data"].map do |row|
      GridiumRow.new(row)
    end
  end

  private
  def get_json
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, :use_ssl => true) {|http|
      http.request(req)
    }
    res.body
  end
end

class GridiumRow
  attr_reader :id, :meter_id, :building_id, :used_energy, :peak_energy, :closing_date, :initial_date, :cost
  def initialize(json)
    @id = json["id"]
    @used_energy = json["attributes"]["used"]
    @peak_energy = json["attributes"]["peak"]
    @closing_date = json["attributes"]["closing"]
    @initial_date = json["attributes"]["initial"]
    @cost = number_to_currency(json["attributes"]["cost"])
  end

  private
  # https://stackoverflow.com/questions/35561553/format-string-as-currency-with-ruby-sinatra
  def number_to_currency(number)
    "$#{number}"
  end
end