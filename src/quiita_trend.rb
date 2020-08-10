require 'net/http'
require 'uri'
require 'json'

class QuiitaTrend
  def articles
    request_url = URI.parse('https://qiita-api.netlify.app/.netlify/functions/trend')
    response = Net::HTTP.get(request_url)

    articles = JSON.parse(response)

    article_titles = []
    article_urls = []

    articles.each do |article|
      article_titles << article['node']['title']
      article_urls << "https://qiita.com/#{article['node']['author']['urlName']}/items/#{article['node']['uuid']}"
    end

    today = Date.today.strftime("%m月%d日")

    # あまりスマートな書き方じゃないのでそのうち別の書き方を模索したい。 
    "【#{today} Quiitaのトレンド記事一覧】\n\n#{article_titles[0]}\n#{article_urls[0]}\n\n#{article_titles[1]}\n#{article_urls[1]}\n\n#{article_titles[2]}\n#{article_urls[2]}\n\n#{article_titles[3]}\n#{article_urls[3]}\n\n#{article_titles[4]}\n#{article_urls[4]}\n\n#{article_titles[5]}\n#{article_urls[5]}\n\n#{article_titles[6]}\n#{article_urls[6]}\n\n#{article_titles[7]}\n#{article_urls[7]}\n\n#{article_titles[8]}\n#{article_urls[8]}\n\n#{article_titles[9]}\n#{article_urls[9]}\n\n#{article_titles[10]}\n#{article_urls[10]}\n\n#{article_titles[11]}\n#{article_urls[11]}\n\n#{article_titles[12]}\n#{article_urls[12]}\n\n#{article_titles[13]}\n#{article_urls[13]}\n\n#{article_titles[14]}\n#{article_urls[14]}\n\n#{article_titles[15]}\n#{article_urls[15]}\n\n#{article_titles[16]}\n#{article_urls[16]}\n\n#{article_titles[17]}\n#{article_urls[17]}\n\n#{article_titles[18]}\n#{article_urls[18]}\n\n#{article_titles[19]}\n#{article_urls[19]}\n\n#{article_titles[20]}\n#{article_urls[20]}\n\n#{article_titles[21]}\n#{article_urls[21]}\n\n#{article_titles[22]}\n#{article_urls[22]}\n\n#{article_titles[23]}\n#{article_urls[23]}\n\n#{article_titles[24]}\n#{article_urls[24]}\n\n#{article_titles[25]}\n#{article_urls[25]}\n\n#{article_titles[26]}\n#{article_urls[26]}\n\n#{article_titles[27]}\n#{article_urls[27]}\n\n#{article_titles[28]}\n#{article_urls[28]}\n\n#{article_titles[29]}\n#{article_urls[29]}"
  end
end
