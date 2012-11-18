require 'spec_helper'

describe VotesController do

  describe "GET 'up'" do
    it "returns http success" do
      get 'up'
      response.should be_success
    end
  end

  describe "GET 'down'" do
    it "returns http success" do
      get 'down'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
