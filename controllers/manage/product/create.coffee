func_product = loadService('product');
func_category = loadService('category');
func_unit = loadService('unit');
EventProxy = require('eventproxy');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'product'
        res.locals.level2 = 'product_create'
        id = req.query.id

        ep = EventProxy.create 'units','categorys','product', (units,categorys,product)->
          res.render('manage/product/create',{data:product,units:units,categorys:categorys})

        func_unit.getUnitsByEventId  req.params.eventId,0,100, (err, data)->
          ep.emit 'units',data

        func_category.getCategorysByEventId  req.params.eventId,0,100, (err, data)->
          ep.emit 'categorys',data

        if id and id isnt ''
          func_product.getProductById id, (err,data)->
            ep.emit 'product',data
        else
          ep.emit 'product',{}
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