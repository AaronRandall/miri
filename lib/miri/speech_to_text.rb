require 'json'

module Miri
  class SpeechToText

    TRANSLATION_URI = "http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium"

    def initialize(audio_file)
      @audio_file = audio_file
    end

    def text
      @text ||= result["utterance"]
    end

    def confidence
      @confidence ||= result["confidence"]
    end

    private

    def result
      @result ||= perform_query   
    end

    def perform_query
      output = `wget -q -U \"Mozilla/5.0\" --post-file #{@audio_file} --header \"Content-Type: audio/x-flac; rate=16000\" -O - \"#{TRANSLATION_URI}\"`

      begin
        JSON.parse(output)["hypotheses"][0]
      rescue Exception => e
        Logger.error("An error occurred creating JSON from the speech_to_text query response (probably no translation was found)")
        Logger.error("#{e.message}")

        # Stub an empty response with zero confidence
        JSON.parse('{"utterance":"","confidence":0}')
      end
    end
  end
end
