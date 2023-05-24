const createReponse = (res, status, body, errorRaw) => {
  errorRaw && console.log(errorRaw.message);
  res.status(status).send(body);
};

module.exports = createReponse;