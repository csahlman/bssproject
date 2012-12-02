# == Schema Information
#
# Table name: meetups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  group_name  :string(255)
#  event_url   :string(255)
#  description :text
#  meetup_time :datetime
#  latitude    :float
#  longitude   :float
#  attending   :integer
#  idiom_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Meetup < ActiveRecord::Base
  require 'open-uri'
  require 'json'

  # def api_key=(key)
    
  # end

  # def api_key
  #   self.api_key
  # end

  def self.fetch_results(topic, zip_code)
    topic = parse_topic(topic)
    # self.api_key = ENV['MEETUP_API']
    api_url = "https://api.meetup.com/2/open_events?key=#{ENV['MEETUP_API']}&sign=true&topic=#{topic}&zip=#{zip_code}&page=20"
    result = JSON.parse(open(api_url).read)
    result   
  end

  def self.parse_topic(topic)
    topics = topic.split(' ').map { |n| n.strip }
    return topics.join(',')
  end

  def self.self_attributes_from_json(meetup_hash)
    
  end

  def self.find_or_create_new_meetups(idiom, zip_code)
    meetup_hash = fetch_results(idiom.title, zip_code)
    set_attributes_from_json(meetup_hash)
  end
end
