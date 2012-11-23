require 'spec_helper'

describe AnnouncementsController do

  describe "GET 'hide'" do
    it "returns http success" do
      get 'hide'
      response.should be_success
    end
  end

end
