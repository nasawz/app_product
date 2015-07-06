func_unit = loadService('unit');
EventProxy = require('eventproxy');

module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'unit'
        res.locals.level2 = 'unit_list'
        page = req.query.page
        page = 0 unless page
        pageSize = 10
        ep = EventProxy.create 'data','count', (data,count) ->
          res.render('manage/unit/index',{data:data,count:count,page:page})
        func_unit.getUnitsCountByEventId req.params.eventId, (err,count)->
          if err
            ep.emit('count', 0)
          else
            ep.emit('count', count)
        func_unit.getUnitsByEventId req.params.eventId, page, pageSize, (err,data)->
          if err
            ep.emit('data', [])
          else
            ep.emit('data', data)

  '/:eventId/delete':
    post:->
      (req, res, next)->
        func_unit.deleteUnitById req.body.id, (err,data)->
          if err
            return res.json(code:500,msg:err,alert:'操作失败',content:'')
          return res.json(code:200,msg:'',alert:'操作成功',content:data)