require 'spec_helper'

describe "MeetupApis" do
  let(:user) { create(:user) }
  let(:idiom) { create(:idiom) }

  describe "not logged in" do
    it "should not request from meetup API" do
      visit idiom_path(idiom)
      response.should_not have_selector('body', content: "See all meetups")      
    end  
  end

  describe "logged in" do
    before { valid_signin(user) }

    it "should have some sort of content from the meetup API" do
      #pending
    end
  end
end
