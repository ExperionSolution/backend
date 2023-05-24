const createReponse = require('./response.handler');

const handleHttp = (res, error, errorRaw) => {
  createReponse(res, 500, {error}, errorRaw);
};
const handleBadRequest = (res, error, errorRaw) => {
  createReponse(res, 400, {error}, errorRaw);
};
const handleNotFound = (res, error, errorRaw) => {
  createReponse(res, 404, {error}, errorRaw);
};

module.exports = {
  handleHttp,
  handleBadRequest,
  handleNotFound,
}