#reload utility from http://stackoverflow.com/questions/3463182/reload-rubygem-in-irb
def reload(require_regex)
  $".grep(/^#{require_regex}/).each {|e| $".delete(e) && require(e) }
end
require './ir_color'
reload './ir_color'

#match the roll at the beginning
#$simple_regex = /^(\d)*d(\d)+[+-]((\d)*d(\d)+|\d+)/
#whitespace woo
$full_dice_regex = /^\s*\d*\s*d\s*\d+(\s*[+-]\s*(\s*\d*\s*d\s*\d+\s*|\s*\d+\s*))*/

module Rollem
  module Dicebox
    colors = { :max => :red }
    RollData = Struct.new(:sides, :value, :coloring);

    class Roll
      attr_reader :fulltext, :roll, :flavor, :components

      def initialize(fulltext)
        @fulltext = fulltext.to_s.strip
        @roll = $full_dice_regex.match(fulltext.to_s).to_s.strip
        @flavor = fulltext.to_s[@roll.length .. -1].strip

        #kill whitespace in roll
        @roll.gsub!(/ /,'')

        #split into separate components
        troll = @roll.dup
        puts "parsing " + troll.to_s
        @breakdown = Array.new()
        i = 0
        case troll  #REMINDER: THIS IS HERE FOR MULTIPLE ROLL TYPES
          when $full_dice_regex
            while (not troll.empty?) and i < 30 ; i += 1
              case troll
                when /^\d*d\d+/     #rolls
                  @breakdown.push($~.to_s)
                  troll = troll[$~.to_s.length .. -1]
                  puts "match - #{$~.to_s} - #{troll}"
                when /^\d+/         #constants
                  @breakdown.push($~.to_s)
                  troll = troll[$~.to_s.length .. -1]
                  puts "match - #{$~.to_s} - #{troll}"
                when /^\+/           #addition
                  @breakdown.push($~.to_s)
                  troll = troll[$~.to_s.length .. -1]
                  puts "match - #{$~.to_s} - #{troll}"
                when /^-/            #subtraction
                  @breakdown.push($~.to_s)
                  troll = troll[$~.to_s.length .. -1]
                  puts "match - #{$~.to_s} - #{troll}"
                else
                  puts "ERROR PARSING BASIC ROLL"
              end
            end
          else
            puts "OH GOD, PANIC"
        end

        @output ="#{@roll} => "
        total_roll = 0
        action = :+

        @breakdown.each do |e|
          #TODO: process the matches here, perform rolls, and create the resulting string
          case e
            when /^\d*d\d+/      #rolls
              split = e.to_s.split('d')
              qty = split[0].to_i
              die = split[1].to_i
              minisum = 0
              rollyrollyrollroll = rollem(qty,die)
              #Hides me brackets
              #if rollyrollyrollroll.length > 1
                @output += "["
              #end
              rollyrollyrollroll.each do |r|
                if r == die       #coloring
                  @output += IRColor.bold.green.to_s + r.to_s + IRColor.clear.to_s
                elsif r == 1
                  @output += IRColor.bold.red.to_s + r.to_s + IRColor.clear.to_s
                else
                  @output += r.to_s
                end
                @output += ' + '
                minisum += r
              end
              @output = @output[0..-4] #truncate final ' + '

              #Hides me brackets
              #if rollyrollyrollroll.length > 1
                @output += "]"
              #end
              if action == :+
                total_roll += minisum
              else
                total_roll -= minisum
              end
            when /^\d+/          #constants
              @output += e.to_s
              if action == :+
                total_roll += e.to_i
              else
                total_roll -= e.to_i
              end
            when /^\+/           #addition
              @output += ' + '
              action = :+
            when /^-/            #subtraction
              @output += ' - '
              action = :-
            else
              puts "ERROR: BOUNCING NEGATIVE METRES"
          end
        end

      end

      def to_s
        #IRColor.red.bold.to_s
        #@roll.to_s + " | " + @flavor.to_s + " | " + @breakdown.to_s
        @output
      end


      #ROLL HEADS
      def rollem(qty,die)
        rolls = Array.new
        qty.times do
          rolls.push(rand(1..die))
        end
        rolls
      end
    end
  end
end