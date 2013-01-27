module Miri
  module AudioPlayer
    AUDIO_PLAYER_BIN="/usr/bin/mplayer"
    
    def self.play(audio_file, audio_dir=SOUNDS_DIR)
      Logger.debug("#{AUDIO_PLAYER_BIN} #{SOUNDS_DIR}/#{audio_file} > /dev/null 2> /dev/null")
      audio_player_output = `#{AUDIO_PLAYER_BIN} #{SOUNDS_DIR}/#{audio_file} > /dev/null 2> /dev/null`

      return true
    end
  end
end
