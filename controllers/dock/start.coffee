# 加载需要用到的service
# func_start = loadService('start');

OAUTH2 = require('bal-oauth');
oauth2 = new OAUTH2('','',config.auth_base_url)
func_event = loadService('event');


module.exports =
  '/':
    get: ->
      (req, res, next) ->
        token = req.query.token
        eventId = req.query.eventId
        unless token
          return res.json({code:400,msg:'token丢失',alert:'操作失败!',content:''})
        else
          oauth2.userByToken token, (err, user)->
            unless user
              return res.json({code:400,msg:'token无效',alert:'操作失败!',content:''})
            else
              if user.role is 'admin'
                func_event.startEventByObj eventId, (err, event) ->
                  return res.json({code:200,msg:'',alert:'操作成功!',content:event})
              else
                func_event.getEventById eventId,(err,data)->
                  if data.userId is user.id
                    func_event.startEventByObj eventId, (err, event) ->
                      return res.json({code:200,msg:'',alert:'操作成功!',content:event})
                  else
                    return res.json({code:400,msg:'',alert:'操作失败!',content:''})