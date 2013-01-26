module Miri
  module Action
    class Spotify < BaseAction
      def process
        Logger.log("In Spotify process")
      end

      def keywords
        ['play some music by', 'play a track by']
      end
    end
  end
end  
