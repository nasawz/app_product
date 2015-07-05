module.exports =
  '/manage*':
    get: ['chkEvent','chkPin']
    post: ['chkEvent','chkPin']