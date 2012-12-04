class ReturnJsonFromUrl 
  require 'open-uri'
  require 'json'

  def initialize(url)
    @url = url
  end

  def return_json_hash
    begin
      return JSON.parse(open(url).read)  
      # explicit return necessary otherwise it bricks
    rescue OpenURI::HTTPError
      nil
    end
  end

  private

    attr_reader :url

end