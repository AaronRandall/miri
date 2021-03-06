require_relative 'base_action' 	

module Miri
  module Action
    class Spotify < BaseAction
  
      # Set to zero to play entire track
      PREVIEW_TRACK_SECONDS=10
      
      def process(artist_text)
        @artist_text = artist_text
        ensure_mpd_is_running
        play_track_for_artist
      end

      def keywords
        [
          'play some music by', 
          'play a track by', 
          'play'
        ]
      end

      private

      def play_track_for_artist
        clear_playlist
        track_uri = find_track

        if track_uri
          Logger.debug("Track found: #{track_uri}")
          play_track(track_uri)

          if PREVIEW_TRACK_SECONDS > 0
            sleep PREVIEW_TRACK_SECONDS
            clear_playlist
          end
        else
          Miri::TextToSpeech("I'm sorry, I couldn't find a track for #{@artist_text}")
        end
      end

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

      def ensure_mpd_is_running
        # Attempt to get the mpd process id
        mpd_pid = `ps -C mopidy -o pid=`

        Logger.debug("mpd_pid: #{mpd_pid}")
        # If no pid exists, start the mpd
        if mpd_pid.strip == ""
          Logger.info("No MPD server running, starting one now. Please rerun your query.")
          `/usr/bin/mopidy &`
        end
      end
    end
  end
end
