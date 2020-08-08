require 'dotenv'
require 'slack-ruby-client'
require './src/weather'

Dotenv.load

API_KEY = ENV['OPEN_WEATHER_API']

Slack.configure do |conf|
  conf.token = ENV['SLACK_BOT_TOKEN']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  case data.text
    when '練馬の気温'
      weather = Weather.new(API_KEY)
      client.message channel: data.channel, text: '現在の練馬の' + weather.weather_info('Nerima')
  end
end

client.on :close do |_data|
  puts 'Client is about to disconnect'
end

client.on :closed do |_data|
  puts 'Client has disconnected successfully!'
end

client.start!
