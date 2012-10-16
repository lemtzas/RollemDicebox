
#reload utility from http://stackoverflow.com/questions/3463182/reload-rubygem-in-irb
def reload(require_regex)
  $".grep(/^#{require_regex}/).each {|e| $".delete(e) && require(e) }
end

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
        case troll
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

        troll.each do |e|
          #TODO: process the matches here, perform rolls, and create the resulting string
        end

      end

      def to_s
        #IRColor.red.bold.to_s
        @roll.to_s + " | " + @flavor.to_s + " | " + @breakdown.to_s
      end
    end


    #ROLL HEADS
    def roll(line)
      sections = line.split(';')

      puts (sections.to_s)

      rolls = Array.new(sections.count)

      #distinguish rolls
      sections.each_index do |i|
        rolls[i] = Roll.new(sections[i]);
      end

      rolls.each do |r|
        puts ("r: " + r.to_s)
      end

      puts (sections.to_s)
    end
  end
end