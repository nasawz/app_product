func_product = loadService('product');
func_category = loadService('category');
EventProxy = require('eventproxy');

module.exports =
  '/:eventId/all':
    get:->
      (req, res, next)->
        res.header 'Access-Control-Allow-Origin', '*'
        res.header 'Access-Control-Allow-Headers', 'X-Requested-With'
        page = req.query.page
        pageSize = req.query.pageSize
        page = 0 unless page
        pageSize = 10 unless pageSize
        ep = EventProxy.create 'data','count', (data,count) ->
          res.json({code:200,msg:'',alert:'操作成功',content:{data:data,count:count,page:page}})
        func_product.getProductsCountByEventId req.params.eventId, (err,count)->
          if err
            ep.emit('count', 0)
          else
            ep.emit('count', count)
        func_product.getProductsByEventId req.params.eventId, page, pageSize, (err,data)->
          if err
            ep.emit('data', [])
          else
            ep.emit('data', data)

  '/:eventId/categorys':
    get:->
      (req, res, next)->
        res.header 'Access-Control-Allow-Origin', '*'
        res.header 'Access-Control-Allow-Headers', 'X-Requested-With'
        page = req.query.page
        pageSize = req.query.pageSize
        page = 0 unless page
        pageSize = 10 unless pageSize
        ep = EventProxy.create 'data','count', (data,count) ->
          res.json({code:200,msg:'',alert:'操作成功',content:{data:data,count:count,page:page}})
        func_category.getCategorysCountByEventId req.params.eventId, (err,count)->
          if err
            ep.emit('count', 0)
          else
            ep.emit('count', count)
        func_category.getCategorysByEventId req.params.eventId, page, pageSize, (err,data)->
          if err
            ep.emit('data', [])
          else
            ep.emit('data', data)

  '/:eventId/products_by_categoryId':
    get:->
      (req, res, next)->
        res.header 'Access-Control-Allow-Origin', '*'
        res.header 'Access-Control-Allow-Headers', 'X-Requested-With'
        page = req.query.page
        pageSize = req.query.pageSize
        page = 0 unless page
        pageSize = 10 unless pageSize
        categoryId = req.query.categoryId
        ep = EventProxy.create 'data','count', (data,count) ->
          res.json({code:200,msg:'',alert:'操作成功',content:{data:data,count:count,page:page}})
        func_product.getProductsCountByCategoryId categoryId, (err,count)->
          if err
            ep.emit('count', 0)
          else
            ep.emit('count', count)
        func_product.getProductsByCategoryId categoryId, page, pageSize, (err,data)->
          if err
            ep.emit('data', [])
          else
            ep.emit('data', data)

  '/:eventId/product_info':
    get:->
      (req, res, next)->
        res.header 'Access-Control-Allow-Origin', '*'
        res.header 'Access-Control-Allow-Headers', 'X-Requested-With'
        id = req.query.id
        func_product.getProductById id, (err,data)->
          res.json({code:200,msg:'',alert:'操作成功',content:data})