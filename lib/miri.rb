module Miri
  ROOT = File.expand_path('..', __FILE__)
  require ROOT + '/miri/logger'
  require ROOT + '/miri/audio_recorder'
  require ROOT + '/miri/speech_to_text' 	
  require ROOT + '/miri/text_to_speech' 	
  require ROOT + '/miri/action' 	
  require ROOT + '/miri/action/echonest' 	
  require ROOT + '/miri/action/spotify' 	
  require ROOT + '/miri/action/songkick' 	
  require ROOT + '/miri/action/musicbrainz' 	

  class Agent
    def capture_audio()
      Miri::TextToSpeech.say("How can I help?")
      Logger.info("In capture_audio")
      audio_recorder = Miri::AudioRecorder.new()
      audio_file = audio_recorder.record
      return audio_file
    end

    def translate_to_text(audio_file)
      speech_to_text = Miri::SpeechToText.new(audio_file) 
      translated_text = speech_to_text.text
      # ToDo: Get speect_to_text.confidence and rerun audio capture if low
      Logger.info("Result of speech_to_text.text is       :#{speech_to_text.text}")
      Logger.info("Result of speech_to_text.confidence is :#{speech_to_text.confidence}")
      return translated_text
    end

    def perform_action(translated_text)
      Logger.info("In perform_action (translated_text=#{translated_text})")
      action = Miri::Action::Agent.new(translated_text)
      action.process
    end

    def report_results(action_result)
      Logger.info("In report_results (action_result=#{action_result})")
    end 
  end
end
