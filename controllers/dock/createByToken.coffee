# 加载需要用到的service
# func_createByToken = loadService('createByToken');
OAUTH2 = require('bal-oauth');
oauth2 = new OAUTH2('','',config.auth_base_url)
func_event = loadService('event');
func_eventExt = loadService('eventExt');

module.exports =
  '/':
    get: ->
      (req, res, next) ->
        token = req.query.token
        title = req.query.title
        userId = req.query.userId
        unless token
          return res.json({code:400,msg:'token丢失',alert:'操作失败!',content:''})
        else
          oauth2.userByToken token, (err, user)->
            unless user
              return res.json({code:400,msg:'token无效',alert:'操作失败!',content:''})
            else
              obj = {}
              obj.title = 'event'
              obj.title = title if title
              obj.userId = user.id
              obj.userId = userId if userId
              func_event.createEvent obj, (err, event) ->
                func_eventExt.createEventExt {id:event.id}, (err, ext)->
                  return res.json({code:200,msg:'',alert:'操作成功!',content:event})

