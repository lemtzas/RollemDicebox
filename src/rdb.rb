
require './dicebox'


module Cinch
  module Plugins
    class RollemDicebox
      include Cinch::Plugin

      @prefix = '' #kill that shitty prefix


      match $full_dice_regex

      match "reload dice"


      def execute(m)
        case m.message
          when "reload dice"
            m.reply "nope"
            load './dicebox.rb'
          when $full_dice_regex
            dice = Rollem::Dicebox::Roll.new(m.message)
            #m.reply "I would roll...but that would be useful"
            #m.reply "instead..." + dice.to_s
            m.reply dice.to_s
        end
      end
    end

  end
end