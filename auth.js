// Small auth helpers used as Express middleware.

function isLoggedIn(req, res, next) {
  if (req.session && req.session.user) return next();
  return res.redirect('/login?next=' + encodeURIComponent(req.originalUrl));
}

function currentUser(req) {
  return req.session && req.session.user ? req.session.user : null;
}

module.exports = { isLoggedIn, currentUser };
