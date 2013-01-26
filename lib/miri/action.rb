module Miri
  module Action
    class BaseAction
      def process
        raise NotImplementedError
      end

      def keywords
        raise NotImplementedError
      end
    end

    class Agent

      def initialize(action_text)
        @action_text = action_text 
      end

      def process
        action_class = find_action_class
        artist_text = artist_text_exists_in_action_text(action_class.keywords) 

        Logger.info("Action class retrieved: #{action_class}")
        Logger.info("Artist text retrieved : #{artist_text}")
        action_class.process if action_class
      end

      private

      def find_action_class
        all_action_classes.each do |current_action_class|
          Logger.info("Action class keywords: #{current_action_class.keywords}")
          if keyword_exists_in_action_text(current_action_class.keywords)
            return current_action_class
          end
        end
      end

      def keyword_exists_in_action_text(keywords)
        if artist_text_exists_in_action_text(keywords)
          return true
        end

        return false
      end

      def artist_text_exists_in_action_text(keywords)
        keywords.each do |keyword|
          Logger.info("Checking keyword #{keyword} against action_text #{@action_text}")
          if starts_with?(@action_text, keyword)
            Logger.info("Subtracting @action_text: #{@action_text} from keyword:#{keyword}")
            artist_text = @action_text.gsub(keyword, "")
            return artist_text
          end
        end

        false
      end

      def all_action_classes
        @action_classes ||= [ Miri::Action::EchoNest.new,
                              Miri::Action::Spotify.new ]
      end

      def starts_with?(text, prefix)
        prefix = prefix.to_s
        text[0, prefix.length] == prefix
      end
    end
  end
end
