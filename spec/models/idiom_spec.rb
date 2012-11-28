# == Schema Information
#
# Table name: idioms
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  description_right :string(255)
#  summary           :string(255)
#

require 'spec_helper'

describe Idiom do
  before do
    @attr= { title: "Valid title", description: "Asdf" }
    @idiom= Idiom.new
    @idiom.title= @attr[:title]
    @idiom.description= @attr[:description]
  end

  it "should not be valid without a title and description" do
    Idiom.new.should_not be_valid
  end

  it "should be valid with valid attributes" do
    @idiom.should be_valid
  end

  it "should not create a profile with too long of a title" do
    @idiom.title= 'a'*1001
    @idiom.should_not be_valid
  end

  describe "associations" do
    let(:my_idiom) { @idiom.save }
    it { should respond_to :tags }
    it { should respond_to :comments }
  end
end
