require 'json'

module Miri
  class SpeechToText
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
      Logger.info("Performing query")
      output = `wget -q -U \"Mozilla/5.0\" --post-file #{@audio_file} --header \"Content-Type: audio/x-flac; rate=16000\" -O - \"http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium\"`
      Logger.info(output)

      begin
        JSON.parse(output)["hypotheses"][0]
      rescue Exception => e
        Logger.error("An error occurred creating JSON from the speech_to_text query response (probably no translation was found)")
        Logger.error("#{e.message}")
      end
    end
  end
end
