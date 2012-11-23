# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  message    :text
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Announcement do
  pending "add some examples to (or delete) #{__FILE__}"
end
