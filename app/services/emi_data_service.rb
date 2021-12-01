require "textmood"
class EmiDataService
  require 'webdrivers'
  require 'watir'
  require 'nokogiri'
  require 'open-uri'

  def initialize
  end

  def call
    payload
  end

  def payload
    browser = Watir::Browser.new :chrome, headless: true
    data = browser.goto("https://www.emirates.com/es/english/help/covid-19/travel-requirements-by-destination")
    html_file = browser.html
    html_doc = Nokogiri::HTML(html_file)
    create_countries(html_doc)
  end

  def create_countries(html_doc)
    html_doc.css(".travel-requirements-list__item").each do |element|
      country = element.css('.travel-requirements-list__item-header').text.split('to')[1]&.strip
      timestamp = element.css(".travel-requirements-list__time-stamp").text
      summary = element.css("p").map {|p| p.text}
      pcr = summary.detect {|e| e.include?("negative COVID‑19 PCR test")}
      quarentine = summary.detect {|e| e.include?("quarantine")}
      existing_country = Country.find_by(name: country)
      tm = TextMood.new(language: "en")
      score = tm.analyze(element.css("p"))
      params = {
          name: country,
          description: summary,
          quarentine: quarentine,
          pcr_needed: pcr,
          address: country,
          score: score,
          last_update: timestamp
      }
      unless existing_country || country.nil?
        Country.create!(params)
      else
        existing_country&.update(params)
      end
    end
  end
end
