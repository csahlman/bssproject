# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  vote_value    :integer          default(0)
#  voteable_id   :integer
#  voteable_type :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Vote do

  before do
    @vote= Vote.new
  end

  it "should have a vote_value of -1 or 1" do
    [0, 5, 'e', 20].each do |num|
      @vote.vote_value= num
      @vote.should_not be_valid
    end

    [-1, 1].each do |num|
      @vote.vote_value= num
      @vote.should be_valid
    end
  end


  
end
