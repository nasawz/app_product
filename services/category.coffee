Category = require('../index.coffee').models.category

module.exports =

  createCategory: (obj,cb) ->
    Category.create obj,(err,data) ->
      cb err,data



  getCategorysByEventId:(eventId, page, pageSize, cb)->
    Category.find {
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

  getCategorysCountByEventId:(eventId, cb)->
    where =
      eventId:eventId
      status:{
        neq:'delete'
      }
    Category.count where, (err, count)->
      cb err,count

  getCategoryById: (id,cb) ->
    Category.findOne {
      where:
        id:id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      cb err,data

  updateCategory: (obj,cb) ->
    Category.findOne {
      where:
        id: obj.id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      data.updateAttributes obj,(err,data)->
        cb err,data


  deleteCategoryById: (id,cb) ->
    Category.findOne {
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