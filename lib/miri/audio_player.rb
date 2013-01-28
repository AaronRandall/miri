module Miri
  module AudioPlayer
    AUDIO_PLAYER_BIN="/usr/bin/mplayer"
    
    def self.play(audio_file, audio_dir=SOUNDS_DIR, playback_speed=1)
      `#{AUDIO_PLAYER_BIN} -speed #{playback_speed} -af scaletempo #{audio_dir}/#{audio_file} 2> /dev/null`
    end
  end
end
