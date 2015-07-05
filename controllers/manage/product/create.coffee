func_product = loadService('product');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'product'
        res.locals.level2 = 'product_create'
        id = req.query.id
        if id and id isnt ''
          func_product.getProductById id, (err,data)->
            res.render('manage/product/create',{data:data})
        else
          res.render('manage/product/create',{data:{}})
    post:->
      (req, res, next)->
        obj = {}
        obj = req.body
        obj.eventId = req.params.eventId
        if obj.id
          func_product.updateProduct obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)
        else
          delete obj.id
          func_product.createProduct obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)