module Miri
  class AudioRecorder
    RECORD_DURATION = 4
    RECORD_SAMPLE_RATE=16000
    
    def record(record_duration=RECORD_DURATION)
      # Record the audio
      `arecord -q -d #{record_duration} -D hw:1,0 -f S16_LE -c 1 -r #{RECORD_SAMPLE_RATE} #{SOUNDS_OUTPUT_DIR}/output.wav &> /dev/null`

      # Convert the recorded audio from wav to flac
      `ffmpeg -loglevel 0 -v 0 -i #{SOUNDS_OUTPUT_DIR}/output.wav -ab 192k -y #{SOUNDS_OUTPUT_DIR}/output.flac 2> /dev/null`

      return "#{SOUNDS_OUTPUT_DIR}/output.flac"
    end
  end
end
