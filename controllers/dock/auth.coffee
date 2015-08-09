# 加载需要用到的service
# func_auth =
_ = require('underscore')
OAUTH2 = require('bal-oauth');
oauth2 = new OAUTH2('','',config.auth_base_url)
func_event = loadService('event');

module.exports =
  '/':
    get: ->
      (req, res, next) ->
        token = req.query.token
        eventId = req.query.eventId
        req.session.referer = req.headers.referer
        req.session.save
        unless token
          return res.json({code:400,msg:'token丢失',alert:'操作失败!',content:''})
        else
          oauth2.userByToken token, (err, user)->
            unless user
              return res.json({code:400,msg:'token无效',alert:'操作失败!',content:''})
            else
              if user.role isnt 'admin'
                if _.findWhere(user.apps, {eventId:eventId})
                  req.session.user = user
                  req.session.save
                  return res.redirect '/manage/product/'+eventId
                else
                  return res.json({code:401,msg:'用户无限权限',alert:'操作失败!',content:''})
              else
                req.session.user = user
                req.session.save
                return res.redirect '/manage/product/'+eventId

