#框架主脚本
require './baleina/BaseInit'
loopback = require('loopback');

module.exports = app = loopback()
boot = require('loopback-boot')
boot app,__dirname+'/server'


ExpressInit = require('./baleina/ExpressInit')
ExpressInit app
