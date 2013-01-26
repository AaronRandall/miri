module Miri
  module TextToSpeech

    TEXT_CHUNK_SIZE=98    

    def self.say(message)
      @message = message

      chunked_message = split_into_chunks 

      chunked_message.each do |chunk| 
        command = "mplayer -ao alsa -noconsolecontrols \"http://translate.google.com/translate_tts?tl=en&q=#{chunk}\" > /dev/null 2>&1"
        Logger.info(command)
        system command
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
