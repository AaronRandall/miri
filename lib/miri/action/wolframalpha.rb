require 'net/http'
require 'json'

module Miri
  module Action
    class WolframAlpha < BaseAction
      def process(artist_text)
        @search_text = artist_text
        Logger.debug("In the WolframAlpha action with search term: #{@search_text}")
        result = perform_query

        #Miri::TextToSpeech.say(result)
      end

      def keywords
        [ 'what is' ]
      end

      private

      def perform_query
        uri = URI("http://api.wolframalpha.com/v2/query?input=what%20is%20the%20biggest%20mammal%20on%20earth&appid=U3TR8A-553KQ7G3RK")
        response = Net::HTTP.get_response(uri)

        Logger.debug(response)
        begin
          result = Hash.from_xml(response.body).to_json

          Logger.debug("Result is: #{result}")
        rescue Exception => e
          Logger.error("An error occurred querying WolframAlpha.")
          Logger.error("#{e.message}")
        end
      end
    end
  end
end

