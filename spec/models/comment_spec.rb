# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  message    :text
#  user_id    :integer
#  idiom_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Comment do

  let(:user) { create(:user) }
  let(:comment) { user.comments.new }

  it "should create a comment with valid attributes" do
    comment.should_not be_valid
  end

end
