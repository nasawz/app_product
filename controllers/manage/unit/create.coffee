func_unit = loadService('unit');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'unit'
        res.locals.level2 = 'unit_create'
        id = req.query.id
        if id and id isnt ''
          func_unit.getUnitById id, (err,data)->
            res.render('manage/unit/create',{data:data})
        else
          res.render('manage/unit/create',{data:{}})
    post:->
      (req, res, next)->
        obj = {}
        obj = req.body
        obj.eventId = req.params.eventId
        if obj.id
          func_unit.updateUnit obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)
        else
          delete obj.id
          func_unit.createUnit obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)