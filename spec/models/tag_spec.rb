# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Tag do
  let(:user) { create(:user) }
  let(:idiom) { create(:idiom) }

  describe "validations" do
    let(:tag) { Tag.new }
    it "should require a name" do
      tag.should_not be_valid        
    end

    it "name should not be too long" do
      tag.name= 'a'*51
      tag.should_not be_valid
    end

    it "should reject names that are the same but different case" do
      tag.name= "test"
      tag.save
      tag2= Tag.new
      tag2.name= "test"
      tag2.should_not be_valid
    end
  end

  context "associations" do 
    let(:tag) { create(:tag) }
    it { tag.should respond_to :tag_associations }
  end  

end
