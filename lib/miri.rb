module Miri
  ROOT = File.expand_path('..', __FILE__)
  require ROOT + '/miri/logger'
  require ROOT + '/miri/audio_recorder'
  require ROOT + '/miri/speech_to_text' 	
  require ROOT + '/miri/action' 	
  require ROOT + '/miri/text_to_speech' 	

  class Agent
    def capture_audio()
      Logger.info("In capture_audio")
      audio_recorder = Miri::AudioRecorder.new()
      audio_file = audio_recorder.record
      return audio_file
    end

    def translate_to_text(audio_file)
      speech_to_text = Miri::SpeechToText.new(audio_file) 
      translated_text = speech_to_text.text
      Logger.info("Result of speech_to_text is #{translated_text}")
      return translated_text
    end

    def perform_action(translated_text)
      Logger.info("In perform_action (translated_text=#{translated_text})")
    end

    def report_results(action_result)
      Logger.info("In report_results (action_result=#{action_result})")
    end 
  end
end
