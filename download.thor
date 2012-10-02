$:.unshift(File.dirname(__FILE__) + '/lib')
require 'hilscher_downloader'
require 'rainbow'

class PageDownloader
  def download_page url, options={}
    force_overwrite = options[:force_overwrite]
    download_dir = options[:download_dir]
    pictures = HilscherDownloader::Page.new(:url => url).picture_links
    pictures.each do |image_url|
      target_path = File.join(download_dir, "hilscher_wallpapers", image_url.split('/').last)
      if File.exist?(target_path) && (force_overwrite == false)
        puts "Skipping #{target_path}, already downloaded".color(:red)
      else
        print "Downloading #{image_url} to #{target_path}... ".color(:red)
        system("wget #{image_url} -O #{target_path} 2>/dev/null")
        puts "[OK]".color(:green)
      end
    end
  end
end

class Download < Thor
  desc "homepage", "Download the homepage pictures"
  method_option :force_overwrite, :type => :boolean, :aliases => "-f", :default => false, :desc => "Overwrites already downloaded pictures [default: false]"
  method_option :download_dir, :type => :string, :aliases => '-d', :default => '/tmp', :desc => "The directory for downloaded pictures"
  def homepage
    PageDownloader.new.download_page(HilscherDownloader::Page::BASE_URL, :overwrite => options.force_overwrite, :download_dir => options.download_dir)
  end

  desc "all", "Download all the pictures"
  method_option :force_overwrite, :type => :boolean, :aliases => "-f", :default => false, :desc => "Overwrites already downloaded pictures [default: false]"
  method_option :download_dir, :type => :string, :aliases => '-d', :default => '/tmp', :desc => "The directory for downloaded pictures"
  def all
    total_pages = HilscherDownloader::Page.new.total_pages
    1.upto(total_pages) do |count|
      puts "Downloading page #{count}/#{total_pages}".color(:yellow)
      page_url = HilscherDownloader::Page::BASE_URL + '?page=' + count.to_s
      PageDownloader.new.download_page(page_url, :overwrite => options.force_overwrite, :download_dir => options.download_dir)
      puts "Page #{count} [OK]".color(:green)
    end
  end

end

