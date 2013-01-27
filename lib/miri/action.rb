module Miri
  module Action
    class BaseAction
      def process(artist_text)
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
        if action_class
          artist_text = artist_text_exists_in_action_text(action_class.keywords) 

          Logger.debug("Action class retrieved: #{action_class}")
          Logger.debug("Artist text retrieved : #{artist_text}")
        else
          # Try the request on WolframAlpha if no specific action class was found
          action_class = Miri::Action::WolframAlpha.new
          artist_text = @action_text
        end

        action_class.process(artist_text)
      end

      private

      def find_action_class
        all_action_classes.each do |current_action_class|
          Logger.debug("Action class keywords: #{current_action_class.keywords}")
          if keyword_exists_in_action_text(current_action_class.keywords)
            return current_action_class
          end
        end

        return nil
      end

      def keyword_exists_in_action_text(keywords)
        if artist_text_exists_in_action_text(keywords)
          return true
        end

        return false
      end

      def artist_text_exists_in_action_text(keywords)
        keywords.each do |keyword|
          Logger.debug("Checking keyword #{keyword} against action_text #{@action_text}")
          if starts_with?(@action_text, keyword)
            Logger.debug("Subtracting @action_text: #{@action_text} from keyword:#{keyword}")
            artist_text = @action_text.gsub(keyword, "")
            return artist_text
          end
        end

        false
      end

      def all_action_classes
        @action_classes ||= [ Miri::Action::EchoNest.new,
                              Miri::Action::Spotify.new,
                              Miri::Action::Songkick.new,
                              Miri::Action::WolframAlpha.new]
      end

      def starts_with?(text, prefix)
        prefix = prefix.to_s
        text[0, prefix.length] == prefix
      end
    end
  end
end
