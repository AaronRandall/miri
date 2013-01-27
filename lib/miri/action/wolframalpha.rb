require 'net/http'
require 'json'
require 'nokogiri'

module Miri
  module Action
    class WolframAlpha < BaseAction
      def process(artist_text)
        @search_text = artist_text
        Logger.debug("In the WolframAlpha action with search term: #{@search_text}")
        result = perform_query

        Miri::TextToSpeech.say(result)
      end

      def keywords
        [ 'what is' ]
      end

      private

      def perform_query
        result = ""

        uri = URI("http://api.wolframalpha.com/v2/query?input=#{URI.escape(@search_text)}&appid=U3TR8A-553KQ7G3RK")
        response = Net::HTTP.get_response(uri)

        Logger.debug(response)
        begin
          xml_doc  = Nokogiri::XML(response.body)
          result = xml_doc.xpath("//queryresult/pod[@primary='true'][1]/subpod/plaintext/text()").text
          Logger.debug("Result is: #{result}")
        rescue Exception => e
          Logger.error("An error occurred querying WolframAlpha.")
          Logger.error("#{e.message}")
        end

        return result
      end
    end
  end
end

