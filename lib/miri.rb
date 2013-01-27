module Miri
  ROOT = File.expand_path('..', __FILE__)

  require ROOT + '/miri/logger'
  require ROOT + '/miri/audio_recorder'
  require ROOT + '/miri/audio_player'
  require ROOT + '/miri/speech_to_text' 	
  require ROOT + '/miri/text_to_speech' 	
  require ROOT + '/miri/action' 	
  require ROOT + '/miri/action/echonest' 	
  require ROOT + '/miri/action/spotify' 	
  require ROOT + '/miri/action/songkick' 	
  require ROOT + '/miri/action/musicbrainz' 	

  MIN_SPEECH_TO_TEXT_CONFIDENCE = 0.5
  SOUNDS_DIR = ROOT + "/../sounds"
  SOUNDS_OUTPUT_DIR = SOUNDS_DIR + "/output"
  Logger::SHOW_DEBUG = true

  class Agent
    def capture_audio
      Miri::AudioPlayer.play("siri_beep.mp3")
      Logger.debug("In capture_audio")
      audio_recorder = Miri::AudioRecorder.new()
      audio_file = audio_recorder.record
      return audio_file
    end

    def translate_to_text(audio_file)
      speech_to_text = Miri::SpeechToText.new(audio_file) 
      translated_text = speech_to_text.text
      Logger.info("I heard '#{speech_to_text.text}'")
      Logger.debug("Result of speech_to_text.text is       :#{speech_to_text.text}")
      Logger.debug("Result of speech_to_text.confidence is :#{speech_to_text.confidence}")

      if speech_to_text.confidence < MIN_SPEECH_TO_TEXT_CONFIDENCE
        Miri::TextToSpeech.say("I'm sorry, I couldn't hear that.")
        return ""
      end

      return translated_text
    end

    def perform_action(translated_text)
      Logger.debug("In perform_action (translated_text=#{translated_text})")
      action = Miri::Action::Agent.new(translated_text)
      action.process if action
    end
  end
end
