Event = require('../index.coffee').models.event

module.exports =

  createEvent: (event,cb) ->
    Event.create event,(err,data) ->
      cb null,data

  getEventById: (id,cb) ->
    Event.findOne {
      where:
        id:id
    },(err,data) ->
      cb null,data

  updateEventByObj: (obj,cb) ->
    Event.findOne {
      where:
        id: obj.eventId
    },(err,data) ->
      target = {}
      target.banner = obj.banner
      data.updateAttributes target,(err,event)->
        cb null,event


  deleteEventByObj: (eventId,cb) ->
    Event.findOne {
      where:
        id: eventId
    },(err,data) ->
      target = {}
      target.status = 'delete'
      data.updateAttributes target,(err,event)->
        cb null,event

  stopEventByObj: (eventId,cb) ->
    Event.findOne {
      where:
        id: eventId
    },(err,data) ->
      target = {}
      target.run = false
      data.updateAttributes target,(err,event)->
        cb null,event

  startEventByObj: (eventId,cb) ->
    Event.findOne {
      where:
        id: eventId
    },(err,data) ->
      target = {}
      target.run = true
      data.updateAttributes target,(err,event)->
        cb null,event
