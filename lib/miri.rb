module Miri
  ROOT = File.expand_path('..', __FILE__)
  require ROOT + '/miri/logger'
  require ROOT + '/miri/audio_recorder'
  require ROOT + '/miri/audio_player'
  require ROOT + '/miri/speech_to_text' 	
  require ROOT + '/miri/text_to_speech' 	
  require ROOT + '/miri/action' 	

  SOUNDS_DIR = ROOT + "/../sounds"
  SOUNDS_OUTPUT_DIR = SOUNDS_DIR + "/output"
  MIN_SPEECH_TO_TEXT_CONFIDENCE = 0.5
  Logger::SHOW_DEBUG = false

  class Agent
    def capture_audio
      Miri::AudioPlayer.play("miri_start.mp3")
      audio_recorder = Miri::AudioRecorder.new()
      audio_file = audio_recorder.record
      Miri::AudioPlayer.play("miri_end.mp3")
      return audio_file
    end

    def translate_to_text(audio_file)
      speech_to_text = Miri::SpeechToText.new(audio_file) 
      translated_text = speech_to_text.text

      if speech_to_text.confidence > MIN_SPEECH_TO_TEXT_CONFIDENCE
        Logger.info("I heard '#{speech_to_text.text}'")
      else
        Miri::TextToSpeech.say("I'm sorry, I couldn't hear that.")
        translated_text = ""
      end

      return translated_text
    end

    def perform_action(translated_text)
      action = Miri::Action::Agent.new(translated_text)
      action.process
    end
  end
end
