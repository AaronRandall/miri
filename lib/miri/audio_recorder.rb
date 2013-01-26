module Miri
  class AudioRecorder
    RECORD_DURATION = 4
    RECORD_SAMPLE_RATE=16000
    OUTPUT_DIR="/home/pi/src/miri/output"
    
    def record
      recording_output = `arecord -d #{RECORD_DURATION} -D hw:1,0 -f S16_LE -c 1 -r #{RECORD_SAMPLE_RATE} #{OUTPUT_DIR}/output.wav > /dev/null`
      conversion_output = `ffmpeg -loglevel 0 -v 0 -i #{OUTPUT_DIR}/output.wav -ab 192k -y #{OUTPUT_DIR}/output.flac > /dev/null 2> /dev/null`

      return "#{OUTPUT_DIR}/output.flac"
    end
  end
end
