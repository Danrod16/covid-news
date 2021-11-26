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
      timestamp = element.css("p").first
      summary = element.css("p")[1].text
      unless Country.find_by(name: country) || country.nil?
        Country.create!(
          name: country,
          description: summary
          )
      end
    end
  end
end
