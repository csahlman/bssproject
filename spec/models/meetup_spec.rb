require 'spec_helper'

describe Meetup do

  describe "parse_topic method" do
    let(:topic) { " Ruby   on Rails " }

    it "should return the parsed URL" do
      topic_response = Meetup.parse_topic(topic)
      topic_response.should eq('Ruby,on,Rails')
    end
  end

end