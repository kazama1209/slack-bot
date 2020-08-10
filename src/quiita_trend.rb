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

    articles_list = "【#{today} Quiitaのトレンド記事一覧】\n\n"

    articles.count.times do |i|
      articles_list.insert(-1, "#{article_titles[i]}\n#{article_urls[i]}\n\n")
    end

    return articles_list
  end
end
