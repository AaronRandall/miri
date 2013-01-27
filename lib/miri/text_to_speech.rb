module Miri
  module TextToSpeech

    TEXT_CHUNK_SIZE=98    
    TRANSLATION_URI="http://translate.google.com/translate_tts?tl=en&q="

    def self.say(message)
      @message = message

      chunked_message = split_into_chunks 

      # Remove any existing chunks of audio data in the sounds directory
      Dir.glob("#{SOUNDS_OUTPUT_DIR}/chunk_*").each { |f| File.delete(f) }

      if chunked_message.length > 1
        Logger.debug("Running concurrent text-to-speech API calls to help with speed.")
        thread_array = []
        chunk_index = 1
        chunked_message.each do |chunk| 
          command = "wget -q -U Mozilla -O \"#{SOUNDS_OUTPUT_DIR}/chunk_#{chunk_index}.mp3\" \"#{TRANSLATION_URI}#{URI.escape(chunk)}'\""
          Logger.debug(command)
          th = Thread.new { system command; sleep 5 }

          thread_array.push(th)
          chunk_index += 1
        end

        # Wait for all text-to-speech threads to complete before continuing
        thread_array.each { |thread| thread.join }

        # Play all chunks in order (and slightly faster than a non-chunked message)
        Miri::AudioPlayer.play("chunk_*.mp3", SOUNDS_OUTPUT_DIR, 1.1)
      else
        Logger.debug("Playing directly with Mplayer")
        Logger.debug("Chunked message: #{chunked_message[0]}")
        `mplayer -ao alsa -noconsolecontrols \"http://translate.google.com/translate_tts?tl=en&q=#{chunked_message[0]}\" > /dev/null 2>&1`
      end
    end

    def self.split_into_chunks
      split_message = @message.split(' ')

      chunk_array = []
      index = 0

      split_message.each do |word|
        if (chunk_array[index].nil?) || ((chunk_array[index].length + word.length) < TEXT_CHUNK_SIZE)
          if chunk_array[index].nil?
            chunk_array[index] = word
          else
            chunk_array[index] = (chunk_array[index] + ' ' + word)
          end
        else
          index += 1
          chunk_array[index] = word
        end

      end

      return chunk_array
    end
  end
end
