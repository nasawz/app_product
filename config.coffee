config =
  appId: 123
  appKey: 123
  port: 8080
  restApiRoot: '/_api'
  auth_base_url: 'http://passport.vk25.com'
  media_res_url:'http://p.baleina.cn/media'
#  media_res_url:'http://127.0.0.1:61045'
  base_path: __dirname
  script_ext: '.coffee'
  assets_head: '/assets'
  session_secret: '1234567'
  rainbow:
    controllers: '/controllers/'
    filters: '/filters/'
    template: '/views/'
module.exports = config
