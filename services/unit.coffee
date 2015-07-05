Unit = require('../index.coffee').models.unit

module.exports =

  createUnit: (obj,cb) ->
    Unit.create obj,(err,data) ->
      cb err,data



  getUnitsByEventId:(eventId, page, pageSize, cb)->
    Unit.find {
      where:
        eventId:eventId
        status:{
          neq:'delete'
        }
      limit:pageSize
      skip:page*pageSize
      order:'created desc'
    },(err,data)->
      cb err,data

  getUnitsCountByEventId:(eventId, cb)->
    where =
      eventId:eventId
      status:{
        neq:'delete'
      }
    Unit.count where, (err, count)->
      cb err,count

  getUnitById: (id,cb) ->
    Unit.findOne {
      where:
        id:id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      cb err,data

  updateUnit: (obj,cb) ->
    Unit.findOne {
      where:
        id: obj.id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      data.updateAttributes obj,(err,data)->
        cb err,data


  deleteUnitById: (id,cb) ->
    Unit.findOne {
      where:
        id: id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      target = {}
      target.status = 'delete'
      data.updateAttributes target,(err,data)->
        cb err,data