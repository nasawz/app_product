Product = require('../index.coffee').models.product

module.exports =

  createProduct: (obj,cb) ->
    if typeof obj['pics[]'] is 'string'
      obj.pics = [obj['pics[]']]
    else
      obj.pics = obj['pics[]']
    Product.create obj,(err,data) ->
      cb err,data



  getProductsByEventId:(eventId, page, pageSize, cb)->
    Product.find {
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

  getProductsCountByEventId:(eventId, cb)->
    where =
      eventId:eventId
      status:{
        neq:'delete'
      }
    Product.count where, (err, count)->
      cb err,count

  getProductById: (id,cb) ->
    Product.findOne {
      where:
        id:id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      cb err,data

  updateProduct: (obj,cb) ->
    Product.findOne {
      where:
        id: obj.id
        status:{
          neq:'delete'
        }
    },(err,data) ->
      if typeof obj['pics[]'] is 'string'
        obj.pics = [obj['pics[]']]
      else
        obj.pics = obj['pics[]']
      data.updateAttributes obj,(err,data)->
        cb err,data


  deleteProductById: (id,cb) ->
    Product.findOne {
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