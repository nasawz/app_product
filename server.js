require('coffee-script/register')

var server = require('./index')
require('http').createServer(server).listen(server.get('port'), function() {
    console.log('server listening on port http://127.0.0.1:' + server.get('port'));
});