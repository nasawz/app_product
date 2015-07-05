# 加载需要用到的service
#func_index = loadService('index');
module.exports =
  '/':
    get: ->
      (req, res, next) ->
        next()
        return