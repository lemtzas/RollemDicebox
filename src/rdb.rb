
require './dicebox'
require './shunting-yard'

module Cinch
  module Plugins
    class RollemDicebox
      include Cinch::Plugin

      @prefix = '' #kill that shitty prefix

      match $full_dice_regex
      match "reload dice"
      match /shunt .*/

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
          when /shunt .*/
            sr = shunt(m.message[6..-1])
            m.reply "shunt it! " + IRColor.grey.to_s + sr.to_s + IRColor.clear.to_s + ' => ' + IRColor.bold.to_s + calculate(sr).to_s

        end
      end
    end

  end
end