require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Hilscher Downloader" do

  it "Inits the homepage with the default url" do
    HilscherDownloader::Page.new.url.should == "http://wallpaper.hilscher.ca/"
  end

  it "Inits the page with another url" do
    HilscherDownloader::Page.new(
      :url => "http://wallpaper.hilscher.ca/?page=2"
    ).url.should == "http://wallpaper.hilscher.ca/?page=2"
  end

  context "Homepage" do
    it "Loads the homepage and retrieves the picture links" do
      VCR.use_cassette('homepage') do
        picture_paths = HilscherDownloader::Page.new.picture_links
        picture_paths.should have(16).pictures
        picture_paths.first.should == "https://s3.amazonaws.com/wallpaper.hilscher.ca/uploads/photo/file/320/0Bdmn.jpg"
      end
    end

    it "gets the total number of pages" do
      VCR.use_cassette('homepage') do
        count = HilscherDownloader::Page.new.total_pages
        count.should == 26
      end
    end
  end

# https://s3.amazonaws.com/wallpaper.hilscher.ca/uploads/photo/file/320/0Bdmn.jpg
# https://s3.amazonaws.com/wallpaper.hilscher.ca/uploads/photo/file/320/thumb_0Bdmn.jpg
end
