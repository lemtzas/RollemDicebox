$nick = "Rollem"

$stop = false

require 'cinch'
require "cinch/plugins/identify"
require './config.rb'
require './rdb'

#reload utility from http://stackoverflow.com/questions/3463182/reload-rubygem-in-irb
def reload(require_regex)
  $".grep(/^#{require_regex}/).each {|e| $".delete(e) && require(e) }
end

begin

  reload 'cinch'
  reload "cinch/plugins/identify"
  reload './rdb'
  reload './config'

  $nick = $config[:nick]

  bot = Cinch::Bot.new do
    configure do |c|
      c.server = $config[:server]
      c.channels = $config[:channels]
      c.nick = $config[:nick]
      c.plugins.plugins = [Cinch::Plugins::RollemDicebox, Cinch::Plugins::Identify]
      c.plugins.options[Cinch::Plugins::Identify] = {
          :username => $config[:nick],
          :password => $config[:pass],
          :type     => $config[:authtype]
      }
    end

    on :message, /(?i)hello,?\s+#{$nick}/ do |m|
      m.reply "Hello, #{m.user.nick}"
    end

    on :message, /(?i)#{$nick}[,\s:]*\s*.*/ do |m|
      trimmed = m.message.to_s[m.message.to_s.match(/#{$nick}[,\s:]/).to_s.size .. -1].strip
      case trimmed
        when /(?i)go die|die/
          $stop = true
          m.reply "#{m.user.nick} is a meanie :S"
          bot.quit
        when /(?i)leave/
          if m.channel
            bot.part(m.channel, "#{m.user.nick} is a meanie :S")
          end
        when /(?i)restart|do over|recalibrate|reroll/
          m.reply "BBS, #{m.user.nick} <3 <3~"
          bot.quit
      end
    end
  end

  bot.start
end while not $stop