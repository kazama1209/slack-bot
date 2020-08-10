require 'net/http'
require 'uri'
require 'json'

class Weather
  def weather_info(locate)
    end_point_url = 'http://api.openweathermap.org/data/2.5/weather'
    api_key = ENV['OPEN_WEATHER_API']

    request_url = URI.parse(end_point_url + "?q=#{locate},jp&APPID=#{api_key}")
    response = Net::HTTP.get(request_url)
    json = JSON.parse(response)

    temp = json['main']['temp']
    celsius = temp - 273.15
    celsius_round = celsius.round

    return "現在の練馬の気温は#{celsius_round.to_s}℃です。"
  end
end
