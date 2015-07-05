EventExt = require('../index.coffee').models.eventExt

module.exports =

  createEventExt:(obj, cb)->
    EventExt.findOne {
      id:obj.id
    },(err,data)->
      if data
        cb null,data
      else
        EventExt.create obj,(err,ext)->
          cb null,ext

  updateEventExt:(obj, cb)->
    EventExt.findOne {
      id:obj.id
    },(err,ext)->
      ext.updateAttributes obj, (err,data)->
        cb null,data

  getEventExtById:(id, cb)->
    EventExt.findOne {
      id:id
    },(err,data)->
      cb null,data