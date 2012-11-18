# == Schema Information
#
# Table name: edits
#
#  id          :integer          not null, primary key
#  idiom_id    :integer
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  edited_at   :datetime
#

require 'spec_helper'

describe Edit do
  pending "add some examples to (or delete) #{__FILE__}"
end
