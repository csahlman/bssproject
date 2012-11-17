require 'spec_helper'

describe IdiomsController do

  describe "GET 'new'" do

    describe "signed out" do
      it "returns http success" do
        get 'new'
        response.should redirect_to sign_in_path
      end  
    end

    describe "signed in" do
      let!(:user) { test_sign_in(create(:user)) }
      it "should be success" do
        get 'new'
        response.should be_success
      end
    end

  end

  describe "POST 'create'" do
    let(:user) { create(:user) }
    before { @attr= { title: "Ruby on rails", description: "Here we go!"} }

    describe "not signed in" do
      it "should not create an idiom" do
        post :create, idiom: @attr
        response.should redirect_to sign_in_path
      end
    end

    describe "signed in" do

      it "should create an idiom with valid attributes" do
        test_sign_in(user)
        post :create, idiom: @attr
        response.should redirect_to assigns(:idiom)
      end

      it "should render the new page with invalid attributes" do
        test_sign_in user
        post :create, idiom: { name: "", description: ""}
        response.should render_template(:new)
      end
    end
  end

  # describe "GET 'destroy'" do
    
  #   describe "when signed in" do
  #     let!(:user) { test_sign_in(create(:user)) }
  #     it "should description" do
        
  #     end
  #   end
  # end

  describe "PUT 'update'" do
    before do
      @attr= { title: "Valid", description: "Valid" }
      @invalid= { title: "", description: ""}
    end

    describe "when signed in" do
      let!(:user) { test_sign_in create(:user) }
      let(:idiom) { create(:idiom) }

      it "should be able to update the idiom with valid attributes" do
        put :update, id: idiom, idiom: @attr
        response.should redirect_to assigns(:idiom)
      end

      it "should rerender edit with invalid attributes" do
        put :update, id: idiom, idiom: @invalid
        response.should render_template(:edit)
      end
    end
  end

  describe "GET 'edit'" do
    describe "when not signed in" do
      let(:idiom) { create(:idiom) }
      it "should go to login path" do
        get :edit, id: idiom
        response.should redirect_to sign_in_path
      end
    end
  end

  describe "GET 'show'" do
    let(:idiom) { create(:idiom) }
    it "returns http success" do
      get :show, id: idiom
      response.should be_success
    end
  end

  describe "GET 'index'" do
    let(:idiom) { create(:idiom) }    
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
