#freenode
freenode = Hash.new
freenode[:server]   = 'irc.freenode.net'
freenode[:channels] = ['#lemocracy']
freenode[:nick]     = 'Rollem'
freenode[:pass]     = 'mydicebringalltheboystotheyard'
freenode[:authtype] = :nickserv

freenode[:admins]   = ["Lemtzas"]

#esper
esper = Hash.new
esper[:server]   = 'irc.esper.net'
esper[:channels] = ['#ThePond']
esper[:nick]     = 'Rollem'
esper[:pass]     = 'mydicebringalltheboystotheyard'
esper[:authtype] = :nickserv

esper[:admins]   = ["Lemtzas"]

#snoonet

snoonet = Hash.new
snoonet[:server]   = 'irc.snoonet.com'
snoonet[:channels] = ['#DnD']
snoonet[:nick]     = 'Rollem'
snoonet[:pass]     = 'mydicebringalltheboystotheyard'
snoonet[:authtype] = :nickserv

snoonet[:admins]   = ["Lemtzas"]

$config = esper
