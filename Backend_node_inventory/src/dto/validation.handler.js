const { handleBadRequest } = require('../utils/error.handler');

const validateFunction = (validation, req, res, next) => {
  const { error } = validation.validate(req.body);
  if (error)  return handleBadRequest(res, error.details[0].message);
  next();
};

module.exports = validateFunction;