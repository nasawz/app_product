func_event = loadService('event');
module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
        res.locals.level1 = 'dashboard'
        res.locals.level2 = ''
        res.render('manage/index')