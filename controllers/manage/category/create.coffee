func_category = loadService('category');
func_product = loadService('product');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'category'
        res.locals.level2 = 'category_create'
        id = req.query.id
        if id and id isnt ''
          func_category.getCategoryById id, (err,data)->
            res.render('manage/category/create',{data:data})
        else
          res.render('manage/category/create',{data:{}})
    post:->
      (req, res, next)->
        obj = {}
        obj = req.body
        obj.eventId = req.params.eventId
        if obj.id
          old = {}
          old.id = obj.id
          newObj = {}
          newObj.name = obj.name
          func_product.updateProductCategory old,newObj,(err, data) ->
          func_category.updateCategory obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)
        else
          delete obj.id
          func_category.createCategory obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)