require 'spec_helper'

describe "AdminDashboards" do

  let(:user) { create(:user, name: "Joe") }
  let(:admin) { create(:user, admin: true) }

  describe "not logged in" do
    it "should not be able to access the admin dashboard" do
      visit admin_path
      response.should have_selector('h1', content: "Sign In")
    end
  end

  describe "logging into the admin dashboard as a normal user" do

    before { valid_signin(user) }

    it "should not be able to access the admin dashboard" do
      response.should_not have_selector('a', content: "Dashboard")
      visit admin_path
      response.should render_template root_path
      response.should have_selector('div.alert-error', content: 'Error')
    end
  end

  describe "logging into the admin dashboard as an admin" do
    
    before { valid_signin(admin) }

    it "should allow access to the control panel and have appropriate links and title" do
      click_link "Dashboard"
      response.should be_success
      response.should have_selector('h1', content: "Admin Dashboard")
      response.should have_selector('title', content: "Admin Dashboard")
      response.should have_selector('a', content: "Manage Users")
      response.should have_selector('a', content: "Manage Idioms")
      response.should have_selector('a', content: "Manage Comments")
    end
    
    describe "managing users" do
      
      # it "should visit the path and delete a user" do
      #   click_link "Dashboard"
      #   click_link "Manage Users"
      #   response.should have_selector('a', content: "Delete")
      #   expect {
      #     click_button "Delete Asshat"
      #   }.to change(User, :count).by(-1)
      # end
    end
  end
end
