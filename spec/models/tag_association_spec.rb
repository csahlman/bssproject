# == Schema Information
#
# Table name: tag_associations
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  idiom_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe TagAssociation do
  it "should require a tag_id and idiom_id" do
    TagAssociation.new.should_not be_valid
  end
end
