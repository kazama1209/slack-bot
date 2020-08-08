require 'net/http'
require 'uri'
require 'json'

class Weather
  def initialize(api_key)
    @api_key = api_key
  end

  def weather_info(locate)
    end_point_url = 'http://api.openweathermap.org/data/2.5/weather'

    request_url = URI.parse (end_point_url + "?q=#{locate},jp&APPID=#{@api_key}")
    response = Net::HTTP.get(request_url)

    json = JSON.parse(response)
    Weather.parse_json(json)
  end

  def self.parse_json(json)
    temp = json['main']['temp']
    celsius = temp - 273.15
    celsius_round = celsius.round
    '気温は' + celsius_round.to_s + '℃です。'
  end
end
