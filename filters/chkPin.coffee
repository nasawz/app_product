

module.exports = (req, res, next) ->
  if req.cookies['menu-pin'] is 'true'
    res.locals.menupin = 'menu-pin'
  else
    res.locals.menupin = ''
  next()
