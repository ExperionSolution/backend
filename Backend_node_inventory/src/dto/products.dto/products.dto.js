const { handleBadRequest } = require('../../utils/error.handler');
const { productCreateValidation } = require('./validation.products')

const validateFunction = (validation, req, res, next) => {
  const { error } = validation.validate(req.body);
  if (error)  return handleBadRequest(res, error.details[0].message);
  next();
};

const productCreateDTO = (req, res, next) => {
  validateFunction(productCreateValidation, req, res, next);
}

module.exports = { 
  productCreateDTO,
}