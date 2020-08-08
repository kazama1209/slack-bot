require 'dotenv'
require 'slack-ruby-client'
require './src/weather'
require './src/cryptocurrency'
require './src/anime_quote'

Dotenv.load

Slack.configure do |conf|
  conf.token = ENV['SLACK_BOT_TOKEN']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  case data.text
    when '練馬の気温は？'
      weather = Weather.new
      client.message channel: data.channel, text: weather.weather_info('Nerima')
    when 'BTC価格は？'
      cryptocurrency = Cryptcurrency.new
      client.message channel: data.channel, text: cryptocurrency.rate_info
    when 'アニメ名言'
      anime_quote = AnimeQuote.new
      client.message channel: data.channel, text: anime_quote.random_output
  end
end

client.on :close do |_data|
  puts 'Client is about to disconnect'
end

client.on :closed do |_data|
  puts 'Client has disconnected successfully!'
end

client.start!
