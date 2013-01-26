module Miri
  module Action
    class EchoNest < BaseAction
      def process
        Logger.info("In EchoNest process")
      end

      def keywords
        ['tell me about', 'biography information for']
      end
    end
  end
end  
