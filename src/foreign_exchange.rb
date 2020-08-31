require 'json'

class ForeignExchange
  def currency_rate
    res = Faraday.get "https://www.gaitameonline.com/rateaj/getrate"
    res_body = JSON.parse(res.body)

    # ドルストレート
    usd_jpy = res_body['quotes'][20]['ask']
    eur_usd = res_body['quotes'][6]['ask']
    gbp_usd = res_body['quotes'][10]['ask']
    aud_usd = res_body['quotes'][14]['ask']
    nzd_usd = res_body['quotes'][19]['ask']
    usd_cad = res_body['quotes'][8]['ask']
    usd_chf = res_body['quotes'][15]['ask']

    usd_straight_pairs = <<-EOS
ドルストレート

USD/JPY: #{usd_jpy}
USD/CAD: #{usd_cad}
USD/CHF: #{usd_chf}
EUR/USD: #{eur_usd}
GBP/USD: #{gbp_usd}
AUD/USD: #{aud_usd}
NZD/USD: #{nzd_usd}
    EOS

    # クロス円
    gbp_jpy = res_body['quotes'][23]['ask']
    aud_jpy = res_body['quotes'][3]['ask']
    nzd_jpy = res_body['quotes'][7]['ask']
    cad_jpy = res_body['quotes'][1]['ask']
    chf_jpy = res_body['quotes'][13]['ask']

    cross_yen_pairs = <<-EOS
クロス円

GBP/JPY: #{gbp_jpy}
AUD/JPY: #{aud_jpy}
NZD/JPY: #{nzd_jpy}
CAD/JPY: #{cad_jpy}
CHF/JPY: #{chf_jpy}
    EOS

    # ユーロクロス
    eur_jpy = res_body['quotes'][16]['ask']
    eur_gbp = res_body['quotes'][9]['ask']
    eur_aud = res_body['quotes'][21]['ask']
    eur_nzd = res_body['quotes'][18]['ask']
    eur_cad = res_body['quotes'][5]['ask']
    eur_chf = res_body['quotes'][12]['ask']

    eur_cross_pairs = <<-EOS
ユーロクロス

EUR/JPY: #{eur_jpy}
EUR/GBP: #{eur_gbp}
EUR/AUD: #{eur_aud}
EUR/NZD: #{eur_nzd}
EUR/CAD: #{eur_cad}
EUR/CHF: #{eur_chf}
    EOS

    fx_info = <<-EOS
```
【外国為替取引情報】

#{usd_straight_pairs}

#{cross_yen_pairs}

#{eur_cross_pairs}
```
    EOS

    return fx_info
  end
end
