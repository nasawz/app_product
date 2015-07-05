module.exports = (req, res, next) ->
  if res.locals.event.run
    next()
  else
    res.json({msg:'活动已停止'})
  return