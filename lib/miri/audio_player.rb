module Miri
  module AudioPlayer
    AUDIO_PLAYER_BIN="/usr/bin/mplayer"
    PLAYBACK_SPEED=1.1
    
    def self.play(audio_file, audio_dir=SOUNDS_DIR)
      audio_player_output = `#{AUDIO_PLAYER_BIN} -speed #{PLAYBACK_SPEED} -af scaletempo #{audio_dir}/#{audio_file} > /dev/null 2> /dev/null`
    end
  end
end
