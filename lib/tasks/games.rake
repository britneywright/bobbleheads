desc "add games"

task :fetch_games => :environment do
  require 'nokogiri'
  require 'watir-webdriver'

class Team
  def initialize(name)
    @name = name
    @url = 'http://mlb.com/schedule/promotions.jsp?c_id='
  end

  def scrape_schedule(name=@name)
    b = Watir::Browser.start(@url + name)
    open("../#{name}.html","w"){|f| f.puts b.html }
    bobblehead_dates(name)
    b.close
  end

  def bobblehead_dates(team)
    page = Nokogiri::HTML(open("../#{team}.html"))
    team_name = page.css("meta[property='og:site_name']")[0]["content"]
    page.css("tr").each do |item|
      date = item.css(".game_date b").text
      formatted_date = date.to_date 
      opponent = item.css(".opponent").text
      promotion = item.css(".promotion .last .promo").text
      if promotion.match(/bobblehead/i)
        Game.find_or_create_by(:date => formatted_date, :team_name => team_name, :opponent => opponent, :promotion => promotion)
      end
    end
  end
end

@teams = ["bal","bos","nyy","tb","tor","cws","cle","det","kc","min","hou","ana","oak","sea","tex","atl","mia","nym","phi","was","chc","cin","mil","pit","stl","ari","col","la","sd","sf"]

@teams.each do |team|
  j = Team.new(team)
  j.scrape_schedule(team)
end
end
