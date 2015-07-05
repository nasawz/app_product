global.config = require('./../config')
path = require('path')

global.loadService = (functionName) ->
  require path.join(config.base_path, 'services', functionName + config.script_ext)