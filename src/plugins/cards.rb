require 'cinch'
require './ir_color.rb'



module Cinch
  module Plugins
    class Cards
      RNG = Random.new()
      DEFAULT_DECK = "standard"
      class Channel
        attr_accessor :cur_deck_name, :deck_hash
        #setup
        def initialize(name)
          @cur_deck_name = DEFAULT_DECK
          @deck_hash = {}
          basedir = $config[:save]
          chandir = basedir + File.PATH_SEPARATOR + channel
          #ensure needed directories are there
          if not Dir.exists?(basedir)
            Dir.mkdir(server)
          end
          if not Dir.exists?(chandir)
            Dir.mkdir(chandir)
          end
        end
        #gets a deck if loaded or persisted
        def getDeck(name = @cur_deck_name)

        end
        #loads a persisted deck
        def loadDeck(name)

        end
        #creates a new deck from a template
        def newDeck(name, template = @cur_deck_name)

        end
        #draws a card from a loaded or persisted deck
        def draw(name = @cur_deck_name)

        end
        #shuffles a loaded or persisted deck
        def shuffle(name = @cur_deck_name)
          getDeck
        end
      end
      #Deck simulates a deck of cards
      class Deck
        #TODO: add various types of decks (pure random, legit)
        #fluff used for output
        FLUFF      = ['"#{m.user} pulls from the stack \"#{card}\"."',
                      '"#{m.user} throws \"#{card}\" down on the table."',
                      '"#{m.user} summons from the chaotic plane \"#{card}\"."',
                      '"#{m.user} salivates over \"#{card}\"."',
                      '"#{m.user} fears drawing \"#{card}\" ever again."',
                      '"#{m.user} believes \"#{card}\" will bring them great glory."',
                      '"#{m.user}: "MEOW" *flip* \"#{card}\""']
        attr_reader :all, :main, :discard, :fluff
        #initial setup
        def initialize(cards, fluff = FLUFF)
          @fluff = fluff
          @all = cards
          @main = @all.shuffle(random: RNG)
          @discard = []
        end

        #draws a card
        def draw
          card = @main.pop
          @discard.push card
          card
        end

        #recombines the deck and shuffles the cards
        def shuffle
          @main = @all.shuffle(random: RNG)
          @discard = []
        end
      end

      DECK_TEMPLATE_LOCATION = "./plugins/cards/deck_templates"
      #strings wrapped in single quotes for later eval
      DECKS = {}
      @channels = {}
      #ChannelName => ChannelCards
      include Cinch::Plugin

      @prefix = '!'

      match /(?i)(deck)(?:\s+([^\s]+))/
      match /(?i)(draw).*/
      match /(?i)(shuffle).*/

      def execute(m, cmd, subcmd, arg)
        deck = "standard"
        puts $config[:save]
        m.reply $config[:save]
        #card = IRColor.bold.to_s + drawCard(deck) + IRColor.clear.to_s
        #m.reply( eval PRECURSORS.sample )
      end

      def drawCard(channel, name)
        draw = getDeck(channel, name)
        draw.sample(random: RNG)
      end

      def getDeck(channel, name)
        #create a channel object if needed
        if not @channels.has_key?(channel)
          @channels[channel] = Channel.new(channel)
        end
        #leave the rest of the work up to the Channel object
        @channels[channel].getDeck
      end

      def loadDeck(channel, name)
        output = Array.new
        if not File.exists?("#{DECK_TEMPLATE_LOCATION}/#{name}.txt")
          return output.push("DECK ABSENT")
        end
        File.open("#{DECK_TEMPLATE_LOCATION}/#{name}.txt") { |file|
          file.each_line do |line|
            output.push(line.chomp)
          end
        }
        DECKS[name] = output
        output
      end

      def unloadDeck(channel, name)
        output = Array.new
        File.new("#{name}.txt")
      end
    end
  end
end
