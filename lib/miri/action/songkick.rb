require_relative 'base_action' 	
require 'net/http'
require 'json'

module Miri
  module Action
    class Songkick < BaseAction
      
      API_KEY="hackday"
      USER_EVENT_URI="http://api.songkick.com/api/3.0/users/"
      SONGKICK_USER_ID="aaronrandall"

      def process(artist_text)
        event = perform_query
        Miri::TextToSpeech.say(event)
      end

      def keywords
        [
         'what is my next gig',
         'what is my next show',
         'what is my next concert',
         'where is my next gig',
         'where is my next show',
         'where is my next concert',
         'gig',
         'concert',
         'what is my next'
        ]
      end

      private

      def perform_query
        uri = URI("#{USER_EVENT_URI}#{SONGKICK_USER_ID}/events.json?apikey=#{API_KEY}")
        response = Net::HTTP.get_response(uri)

        begin
          event = JSON.parse(response.body)["resultsPage"]["results"]["event"][0]

          artist_name = event["performance"][0]["artist"]["displayName"]
          venue_name = event["venue"]["displayName"]
          metro_area_name = event["venue"]["metroArea"]["displayName"]
          date = event["start"]["date"]

          "You're next concert is to see #{artist_name}, at #{venue_name} in #{metro_area_name}, on #{date}." 
        rescue Exception => e
          Logger.error("An error occurred querying the users next event from Songkick.")
        end
      end
    end
  end
end

