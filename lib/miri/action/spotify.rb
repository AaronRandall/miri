module Miri
  module Action
    class Spotify < BaseAction
  
      PREVIEW_TRACK_SECONDS=10
      
      def process(artist_text)
        @artist_text = artist_text
        Logger.debug("In Spotify process with #{artist_text}")
        play_track_for_artist
      end

      def play_track_for_artist
        clear_playlist
        track_uri = find_track
        Logger.debug("Track found: #{track_uri}")
        play_track(track_uri)

        if PREVIEW_TRACK_SECONDS > 0
          sleep PREVIEW_TRACK_SECONDS
          clear_playlist
        end
      end

      def keywords
        ['play some music by', 'play a track by', 'play']
      end

      private

      def find_track
        search_result = `mpc find any "#{@artist_text}" | grep -m 1 "track"`
      end

      def play_track(track_uri)
        `mpc add #{track_uri}`
        `mpc play`
      end

      def clear_playlist
        `mpc clear`
      end
    end
  end
end  
