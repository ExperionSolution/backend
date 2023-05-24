const createReponse = require('./response.handler');

const handleSuccess = (res, body) => {
  createReponse(res, 200, body); 
};
const handleCreate = (res, body) => {
  createReponse(res, 201, body);
};
const handleNotContent = (res, body) => {
  createReponse(res, 204, body);
};

module.exports = {
  handleSuccess,
  handleCreate,
  handleNotContent,
}