module.exports = function mountRestApi(server) {
  server.use(config.restApiRoot, server.loopback.rest());
};
