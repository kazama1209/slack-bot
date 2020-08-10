require 'ruby_coincheck_client'

class Cryptcurrency
  def rate_info
    cc = CoincheckClient.new(ENV['CC_API_KEY'], ENV['CC_SECRET_KEY'])

    response = cc.read_rate
    json = JSON.parse(response.body)

    rate = json['rate']
    return "現在のBTC価格は#{rate.to_s}円です。"
  end
end
