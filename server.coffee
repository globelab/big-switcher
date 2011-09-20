fs   = require 'fs'
http = require 'http'
express  = require 'express'

app = express.createServer()
app.listen(1337)

app.get '/', (req,res) ->
	res.sendfile __dirname + '/controller.html'
	
app.get '/viewer', (req,res) ->
	res.sendfile __dirname + '/viewer.html'
	
app.get '/images/:id', (req,res) ->
	res.sendfile __dirname + '/images/' + req.params.id + '.jpg'

io = require('socket.io').listen app

io.sockets.on 'connection', (socket) ->

  socket.on 'publish', (message) ->
    io.sockets.send message

  socket.on 'broadcast', (message) ->
    socket.broadcast.send message

  socket.on 'whisper', (message) ->
    socket.broadcast.emit 'secret', message
