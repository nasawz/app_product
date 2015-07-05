config = require('./../config')
Path = require('path')
filtersConfig = require('./../filters.config')

Controller = (app, func, path, method) ->
  @func = func
  @filters = []
  @afterFilters = []
  @mainRounte = null
  @method = method
  @path = path
  @name = path.replace(/.*\//, '')
  @newName = null
  self = this
  #检查全局的filter配置
  for route of filtersConfig
    reg = new RegExp(route)
    routeConfig = filtersConfig[route]
    for _method of routeConfig
      if _method == @method
        if reg.test('/' + @path)
          routeConfig[_method].forEach (f) ->
            self.filters.push require(Path.join(config.base_path, config.rainbow.filters, f))
            return

  @renderRoute = (req, res, next) ->
    if !path
      path = 'index'
    res.render path + '.html'
    return

  @mainRoute = func.call(this)
  return

Controller.prototype =
  getRoutes: ->
    @filters.concat([ @mainRoute ]).concat [ @renderRoute ]
  useFilters: (filters) ->
    self = this
    filters.forEach (filter_path) ->
      self.filters.push require(Path.join(config.base_path, config.rainbow.filters, filter_path))
      return
    return
  useAfterFilters: (filters) ->
    self = this
    filters.forEach (filter_path) ->
      self.afterFilters.push require(Path.join(config.base_path, config.rainbow.filters, filter_path))
      return
    return
  rename: (name) ->
    @newName = name
    return
module.exports = Controller