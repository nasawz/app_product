func_product = loadService('product');
EventProxy = require('eventproxy');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'product'
        res.locals.level2 = 'product_list'
        page = req.query.page
        page = 0 unless page
        pageSize = 10
        ep = EventProxy.create 'data','count', (data,count) ->
          res.render('manage/product/index',{data:data,count:count,page:page})
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

  '/:eventId/delete':
    post:->
      (req, res, next)->
        func_product.deleteProductById req.body.id, (err,data)->
          if err
            return res.json(code:500,msg:err,alert:'操作失败',content:'')
          return res.json(code:200,msg:'',alert:'操作成功',content:data)