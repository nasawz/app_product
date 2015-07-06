func_eventExt = loadService('eventExt');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'setting'
        res.locals.level2 = ''
        func_eventExt.getEventExtById req.params.eventId, (err, data)->
          if data
            res.render('manage/setting/index',{data:data})
          else
            res.render('manage/setting/index',{data:{}})
    post:->
      (req, res, next)->
        obj = {}
        obj = req.body
        obj.eventId = req.params.eventId
        if obj.id
          func_eventExt.updateEventExt obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)
        else
          func_eventExt.createEventExt obj, (err, data)->
            if err
              return res.json(code:500,msg:err,alert:'操作失败',content:'')
            return res.json(code:200,msg:'',alert:'操作成功',content:data)