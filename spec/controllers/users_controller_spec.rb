require 'spec_helper'

describe UsersController do
  describe "POST create" do
    let(:user) { User.new }
    let(:user_variables) { { name: "Charlie", email: "csahlman@gmail.com", password: "foobar",
        password_confirmation: "foobar", about_me: "this is I" } }  
    let(:invalid_attributes) { { name: "Charlie", email: "asdf", password: "",
        password_confirmation: " ", about_me: ""} }    

    context "valid attributes" do
      it "should create a new user with valid attributes and redirect to user" do
        post :create, user: user_variables
        response.should redirect_to assigns(:user)
        #assigns(:user) uses the object that was created
      end
    end

    context "invalid attributes" do
      before { post :create, user: invalid_attributes }
      it "should not create a new user" do
        response.should render_template(:new)
      end

      it "should not change the user count" do
        expect { response }.to_not change(User, :count)
      end
    end
  end

  describe "'GET' new" do
    it "should be success" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "'GET' edit" do
    let(:valid_user) { test_sign_in create(:user) }
    let(:user) { create(:user) }
    it "should be success for a signed in user" do
      get :edit, id: valid_user
      response.should render_template(:edit)
    end

    it "should redirect for a different user" do
      get :edit, id: user
      response.should redirect_to sign_in_path
    end
  end

  describe "'GET' index" do
    it "should be success" do
      get :index
      response.should render_template(:index)
    end
  end

  describe "'GET' show" do
    let(:valid_user) { create(:user) }
    it "should be success" do
      get :show, id: valid_user
      response.should be_success 
    end
  end

  describe "'DELETE' destroy" do
    let!(:valid_user) { create(:user) }
    let!(:another_user) { create(:user) } 
    #let! creates it right away.  Will give an error if there is only 1 user

    describe "logged in" do
      before { test_sign_in(valid_user) }
      it "should delete the user" do
        expect { 
          delete :destroy, id: valid_user
        }.to change(User, :count).by(-1)
      end

      it "should not be able to delete another user" do
        expect {
          delete :destroy, id: another_user
        }.to_not change(User, :count)
      end
    end

    describe "logged out" do
      it "should not delete the user" do
        expect {
          delete :destroy, id: valid_user
        }.to_not change(User, :count)
      end
    end

  end

  describe "'PUT' update" do
    let!(:user) { test_sign_in create(:user) }
    let!(:second_user) { create(:user) }

    context "valid attributes" do
      it "should  update with valid attributes" do
        put :update, id: user, user: attributes_for(:user)
        response.should redirect_to assigns(:user)
      end

      it "should not update another user's profile" do
        put :update, id: second_user, user: attributes_for(:user)
        response.should redirect_to root_path
      end
    end

    context "invalid attributes" do
      before { @attr= { name: "", email: "", password: "",
        password_confirmation: "", about_me: ""} }
      it "should not update with invalid attributes" do
        put :update, id: user, user: @attr
        response.should render_template(:edit)
      end
      
    end
  end
end
