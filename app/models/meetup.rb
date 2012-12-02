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

  belongs_to :idiom

  def self.fetch_results(topic, zip_code)
    topic = parse_topic(topic)
    api_url = "https://api.meetup.com/2/open_events?key=#{ENV['MEETUP_API']}&sign=true&topic=#{topic}&zip=#{zip_code}&page=20"
    result = JSON.parse(open(api_url).read)
    result   
  end

  def self.parse_topic(topic)
    topics = topic.split(' ').map { |n| n.strip }
    topics.join(',')
  end

  def self.set_attributes_from_json(meetup_hash, meetup)
    meetup.name = meetup_hash['results'][0]['name']
    meetup.group_name = meetup_hash['results'][0]['group']['name']
    meetup.event_url = meetup_hash['results'][0]['event_url']
    meetup.description = meetup_hash['results'][0]['description']
    meetup.meetup_time = Time.at((meetup_hash['results'][0]['time'])/1000)
    meetup.latitude = meetup_hash['results'][0]['venue']['lat']
    meetup.longitude = meetup_hash['results'][0]['venue']['lon']
    meetup.attending = meetup_hash['results'][0]['yes_rsvp_count']
    meetup.save!
  end

  def self.find_or_create_new_meetups(idiom, zip_code)
    meetup_hash = fetch_results(idiom.title, zip_code)
    new_meetup = idiom.meetups.new
    set_attributes_from_json(meetup_hash, new_meetup) unless meetup_hash['results'].nil?
  end
end
