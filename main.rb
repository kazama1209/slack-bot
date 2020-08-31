require 'dotenv'
require 'pry'
require 'slack-ruby-client'
require 'sinatra'
require './src/weather'
require './src/foreign_exchange'
require './src/cryptocurrency'
require './src/anime_quote'
require './src/quiita_trend'

Dotenv.load

Slack.configure do |conf|
  conf.token = ENV['SLACK_BOT_TOKEN']
end

get '/' do
  'Hello World!'
end

post '/webhook' do
  client = Slack::Web::Client.new

  channel_id = params['channel_id']
  command = params['command']

  case command
    when '/nerima'
      weather = Weather.new
      client.chat_postMessage channel: channel_id, text: weather.current_temp('Nerima'), as_user: true
    when '/btc'
      cryptocurrency = Cryptcurrency.new
      client.chat_postMessage channel: channel_id, text: cryptocurrency.btc_rate, as_user: true
    when '/fx'
      foreign_exchange = ForeignExchange.new
      client.chat_postMessage channel: channel_id, text: foreign_exchange.currency_rate, as_user: true
    when '/anime'
      anime_quote = AnimeQuote.new
      client.chat_postMessage channel: channel_id, text: anime_quote.random_output, as_user: true
    when '/quiita'
      quiita_trend = QuiitaTrend.new 
      client.chat_postMessage channel: channel_id, text: quiita_trend.articles, as_user: true
  end

  return
end
