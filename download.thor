$:.unshift(File.dirname(__FILE__) + '/lib')
require 'hilscher_downloader'
require 'rainbow'

class PageDownloader
  def download_page url
    pictures = HilscherDownloader::Page.new(:url => url).picture_links
    pictures.each do |image_url|
      target_path = File.join("/tmp/downloaded_pictures", image_url.split('/').last)
      unless File.exist?(target_path)
        print "Downloading #{image_url} to #{target_path}... ".color(:red)
        system("wget #{image_url} -O #{target_path} 2>/dev/null")
        puts "[OK]".color(:green)
      else
        puts "Skipping #{target_path}, already downloaded".color(:red)
      end
    end
  end
end

class Download < Thor
  desc "homepage pictures", "download the homepage pictures"
  def homepage
    PageDownloader.new.download_page(HilscherDownloader::Page::BASE_URL)
  end

  desc "All pictures", "download all the pictures"
  def all
    total_pages = HilscherDownloader::Page.new.total_pages
    1.upto(total_pages) do |count|
      puts "Downloading page #{count}/#{total_pages}".color(:yellow)
      page_url = HilscherDownloader::Page::BASE_URL + '?page=' + count.to_s
      PageDownloader.new.download_page(page_url)
      puts "Page #{count} [OK]".color(:green)
    end
  end

end

