#freenode
freenode = Hash.new
freenode[:server]   = 'irc.freenode.net'
freenode[:channels] = ['#lemocracy']
freenode[:nick]     = 'imdum'
freenode[:pass]     = 'imdum'
freenode[:authtype] = :nickserv

freenode[:admins]   = ["Lemtzas"]

#esper
esper = Hash.new
esper[:server]   = 'irc.esper.net'
esper[:channels] = ['#ThePond']
esper[:nick]     = 'imdum'
esper[:pass]     = 'imdum'
esper[:authtype] = :nickserv

esper[:admins]   = ["Lemtzas"]

$config = esper
