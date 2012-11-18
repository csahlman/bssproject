w# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  about_me        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  remember_token  :string(255)
#

require 'spec_helper'

describe User do

  before do
    @attr= { name: "Jimmie", email: "csahlman@foobar.com"}
    @user= User.new
    @user.name= @attr[:name]
    @user.email= @attr[:email]
    @user.password= "foobar"
    @user.password_confirmation= "foobar"
  end
  it "creates a user with valid attributes" do
    @user.should be_valid
  end


  describe "validations" do

    it "should require a proper name" do
      @user.name= ""
      @user.should_not be_valid
      @user.name= 'a'*51
      @user.should_not be_valid
    end

    it "should require a proper email" do
      email= %w[asdfaf@asdf, dasf@foo.fooosadf, jimmy@.com]
      email.each do |e|
        @user.email= e
        @user.should_not be_valid
      end  
    end

    it "should not create 2 users with the same email address" do
      @user.save
      @user2= User.new
      @user2.name= @attr[:name]
      @user2.email= @attr[:email]
      @user2.should_not be_valid
    end
  end

  describe "methods" do
    describe "ensure_an_admin_remains" do
      let(:user) { create(:user) }
      it "should not be able to delete the only user" do
        lambda { user.destroy }.should raise_error 
        #needs to be in a lambda block or it won't let me destroy the last user
      end
    end

    describe "remember_token" do
      it "should create a remember token on save" do
        @user.remember_token.should be_nil
        @user.save
        @user.remember_token.should_not be_nil
      end
    end

    # let(:user) { FactoryGirl.create(:user) }

  end

  describe "associations" do
    let(:user) { create(:user) }
    
    it { should respond_to :comments }
    # it { should respond_to :idioms }
  end
end
