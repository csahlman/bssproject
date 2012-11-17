require 'spec_helper'

describe "UserCreations" do
  describe "creating a user" do
    before { @attr= { name: "Charlie", email: "asf@foo.com", password: "foobar",
        password_confirmation: "foobar", about_me: "asdfasdf"} }

    it "should visit the signin path and create a user" do
      visit new_user_path
      response.should have_selector('h1', content: "Sign up")  
      fill_in "Name", with: @attr[:name]
      fill_in "Email", with: @attr[:email]
      fill_in "Password", with: @attr[:password]
      fill_in "Confirm Password", with: @attr[:password]
      fill_in "About Me", with: @attr[:about_me]
      click_button "Create User"
      response.should have_selector("div", content: "#{@attr[:name]}")
    end

    it "should visit the sign in path and fail" do
      visit new_user_path
      fill_in "Name", with: ""
      fill_in "Email", with: @attr[:email]
      fill_in "Password", with: @attr[:password]
      fill_in "Confirm Password", with: @attr[:password]
      fill_in "About Me", with: @attr[:about_me]
      click_button "Create User"
      response.should have_selector("div.field_with_errors", content: "Name")      
    end
        
  end
end
