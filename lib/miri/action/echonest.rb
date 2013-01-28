require_relative 'base_action' 	
require 'net/http'
require 'json'

module Miri
  module Action
    class EchoNest < BaseAction

      API_KEY='YP3SF1D1HUU0YALC5'
      BIO_URI='http://developer.echonest.com/api/v4/artist/biographies'
      BIO_MAX_LENGTH_CHARS=500
      BIO_MAX_SENTENCES=1

      def process(artist_text)
        @artist_text = artist_text
        Logger.debug("In EchoNest process with #{@artist_text}")
        bio = perform_query
        Logger.debug("Bio retrieved: #{bio}")

        Miri::TextToSpeech.say(bio)
      end

      def keywords
        [
          'tell me about', 
          'tell me more about', 
          'biography information for'
        ]
      end

      private

      def perform_query
        bio = ""

        uri = URI("#{BIO_URI}?api_key=#{API_KEY}&name=#{URI.escape(@artist_text)}&format=json&results=1&start=0&license=cc-by-sa") 
        response = Net::HTTP.get_response(uri)

        begin
          bio = JSON.parse(response.body)["response"]["biographies"][0]["text"]
        rescue Exception => e
          Logger.error("An error occurred retrieving a bio using EchoNest for artist #{@artist_name}")
        end

        # Limit the bio by sentence count and max length
        bio = bio.split('.')[0..BIO_MAX_SENTENCES].join('.')
        bio = bio[0..BIO_MAX_LENGTH_CHARS] 
      end
    end
  end
end  
