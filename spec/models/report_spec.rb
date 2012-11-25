# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  reportable_type :string(255)
#  reportable_id   :integer
#  user_id         :integer
#  message         :text
#  resolved        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Report do
  pending "add some examples to (or delete) #{__FILE__}"
end
