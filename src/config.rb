#freenode
freenode = Hash.new
freenode[:server]   = 'irc.freenode.net'
freenode[:channels] = ['##StarboundD&D']
freenode[:nick]     = 'Rollem'
freenode[:save]     = './persist/freenode'
freenode[:pass]     = 'mydicebringalltheboystotheyard'
freenode[:authtype] = :nickserv

freenode[:admins]   = ["Lemtzas"]

#esper
esper = Hash.new
esper[:server]   = 'irc.esper.net'
esper[:channels] = ['#ThePond']
esper[:nick]     = 'Rollem'
esper[:save]     = './persist/esper'
esper[:pass]     = 'mydicebringalltheboystotheyard'
esper[:authtype] = :nickserv

esper[:admins]   = ["Lemtzas"]

#snoonet

snoonet = Hash.new
snoonet[:server]   = 'irc.snoonet.com'
snoonet[:channels] = ['#DnD']
snoonet[:nick]     = 'Rollem'
snoonet[:save]     = './persist/snoonet'
snoonet[:pass]     = 'mydicebringalltheboystotheyard'
snoonet[:authtype] = :nickserv

snoonet[:admins]   = ["Lemtzas"]




$config = esper




if not Dir.exists? "./persist"
  Dir.mkdir "./persist"
end
if not Dir.exists?( $config[:save] )
  Dir.mkdir( $config[:save] )
end

