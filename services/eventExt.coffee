EventExt = require('../index.coffee').models.eventExt

module.exports =

  createEventExt:(obj, cb)->
    EventExt.findOne {
      where:
        id:obj.eventId
    },(err,data)->
      if data
        cb null,data
      else
        obj.id = obj.eventId
        EventExt.create obj,(err,ext)->
          cb null,ext

  updateEventExt:(obj, cb)->
    EventExt.findOne {
      where:
        id:obj.id
    },(err,ext)->
      ext.updateAttributes obj, (err,data)->
        cb null,data

  getEventExtById:(id, cb)->
    EventExt.findOne {
      where:
        id:id
    },(err,data)->
      cb null,data