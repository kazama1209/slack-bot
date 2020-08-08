require "open-uri"
require "nokogiri"

class AnimeQuote
  def random_output
    url = 'https://dtv.jp/articles-4202'

    charset = nil
    
    html = open(url) do |page|
      charset = page.charset
      page.read
    end

    anime_quotes = []
    
    doc = Nokogiri::HTML.parse(html, nil, charset)

    doc.xpath('//h3').each do |node|
      anime_quotes << node.text
    end

    anime_quote = anime_quotes.sample

    if anime_quote[4] == " "
      anime_quote[5..-1]
    else
      anime_quote[4..-1]
    end
  end
end
