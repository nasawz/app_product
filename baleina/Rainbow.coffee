glob = require('glob')
methods = require('methods')
fs = require('fs')
BaseController = require('./BaseController')
config = require('./../config')

###*
# Main function to initialize routers of a Express app.
#
# @param  {Express} app  Express app instance
# @param  {Object} paths (optional) For configure relative paths of
#                        controllers and filters rather than defaults.
###

exports.route = (app, paths) ->
  paths = paths or {}
  app.set 'views', config.base_path + paths.template
  ctrlDir = config.base_path + (paths.controllers or '/controllers')
  fltrDir = config.base_path + (paths.filters or '/filters')
  tplDir = config.base_path + (paths.template or '/templates')
  glob.sync(ctrlDir + '/**/*.+(js|coffee)').forEach (file) ->
    file = file.replace(/\/index\.(js|coffee)$/, '')
    router = require(file)
    single = typeof router == 'function'
    path = file.replace(ctrlDir.replace(/\/$/, ''), '').replace(/\.(js|coffee)$/, '')
    tplPath = tplDir + path + '.html'
    isTplExist = fs.existsSync(tplPath)

    setup = (req, res, next) ->
      req.rb_path = path
      return

    # '-----------------为windows修正path'
    path = path.replace(/.*\/controllers/, '')
    for i of router
      p = path + i
      if p != '/'
        p = p.replace(/\/$/, '')
      r = router[i]
      methods.forEach (method) ->
        eachRouter = r[method]
        if eachRouter
          controller = new BaseController(app, eachRouter, p.replace(/^\//, ''), method)
          if controller.newName
            console.log 'controller.newName', controller.newName
            p = p.replace(controller.name, controller.newName)
            console.log 'route:' + method + ':' + p
            app[method].apply app, [ p ].concat(controller.getRoutes())
          else
            console.log 'route:' + method + ':' + p
            app[method].apply app, [ p ].concat(controller.getRoutes())
        return
    return
  return
