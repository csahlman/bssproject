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
#  event_id    :integer
#  address     :string(255)
#  city        :string(255)
#  state       :string(255)
#

class Meetup < ActiveRecord::Base
  require 'open-uri'
  require 'json'

  belongs_to :idiom

  scope :recent, -> { where("created_at >= :yesterday", yesterday: 24.hours.ago) }
  scope :future_event, -> { where("meetup_time >= :now", now: Time.zone.now) }

  def self.fetch_results(topic, zip_code)
    topic = parse_topic(topic)
    api_url = "https://api.meetup.com/2/open_events?key=#{ENV['MEETUP_API']}&sign=true&topic=#{topic}&zip=#{zip_code}&page=3"
    begin
      result = JSON.parse(open(api_url).read)
    rescue OpenURI::HTTPError
      # rescue from bad request 400 error
      result = nil
    end
    result   
  end

  def self.parse_topic(topic)
    topics = topic.split(' ').map { |n| n.strip }
    topics.join(',')
  end

  def self.set_attributes_from_json(meetup_hash, idiom)
    meetups = []
    meetup_hash['results'].each do |result| # hash['results'] returns any array obviously
      unless where(event_id: result['id']).any?
        meetup = idiom.meetups.new
        meetup.event_id = result['id']
        meetup.name = result['name']
        meetup.group_name = result['group']['name']
        meetup.event_url = result['event_url']
        meetup.description = result['description']
        meetup.meetup_time = Time.at((result['time'])/1000) 
        #converts time in seconds to date.  was in milliseconds til /1000
        meetup.latitude = result['venue']['lat']
        meetup.longitude = result['venue']['lon']
        meetup.address = result['venue']['address_1']
        meetup.state = result['venue']['state']
        meetup.city = result['venue']['city']
        meetup.attending = result['yes_rsvp_count']
        meetup.save!
        meetups << meetup
      end
    end
    meetups
  end

  def self.find_or_create_new_meetups(idiom, zip_code)
    meetups = []
    if future_event.recent.where(idiom_id: idiom.id).any?
      future_event.recent.where(idiom_id: idiom.id).limit(3) #find the 3 most recent future events for the given idiom 
      # and return the first 3
    else # if there aren't stored values from the last day, fetch new results
      meetup_hash = fetch_results(idiom.title, zip_code)
      meetup_hash && meetup_hash['results'].any? ? set_attributes_from_json(meetup_hash, idiom) : meetups      
      # if there are any results, and there aren't already 3, return the newly set meetup array + the rest of the recent ones
      # just to avoid saving duplicates
    end
  end
end
