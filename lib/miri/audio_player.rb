module Miri
  module AudioPlayer
    AUDIO_PLAYER_BIN="/usr/bin/mplayer"
    
    def self.play(audio_file, audio_dir=SOUNDS_DIR, playback_speed=1)
      audio_player_output = `#{AUDIO_PLAYER_BIN} -speed #{playback_speed} -af scaletempo #{audio_dir}/#{audio_file} > /dev/null 2> /dev/null`
    end
  end
end
