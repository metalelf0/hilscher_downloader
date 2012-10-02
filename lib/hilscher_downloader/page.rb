require 'nokogiri'
require 'faraday'

module HilscherDownloader
  class Page

    BASE_URL = "http://wallpaper.hilscher.ca/"

    attr_accessor :url
    attr_accessor :body

    def initialize args={}
      @url = args[:url] || BASE_URL
    end

    def picture_links
      fetch_page
      urls = @document.css(".collection .photo img").map { |thumb| thumb.attribute('src').value.gsub("thumb_", "") }
    end

    def total_pages
      fetch_page
      @document.css("nav.pagination .last a").attribute('href').value.gsub('/?page=', '').to_i
    end

    private

    def fetch_page
      response = Faraday.new(:url => @url).get
      @document = Nokogiri::HTML(response.body)
    end
  end
end
