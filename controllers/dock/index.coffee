# 加载需要用到的service
# func_index = loadService('index');
started = new Date
module.exports =
  '/':
    get: ->
      (req, res, next) ->
        res.send
          started: started
          uptime: (Date.now() - Number(started)) / 1000
        return