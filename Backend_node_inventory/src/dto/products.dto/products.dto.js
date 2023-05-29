const { productCreateValidation } = require('./validation.products');
const validateFunction = require('../validation.handler');

const productCreateDTO = (req, res, next) => {
  validateFunction(productCreateValidation, req, res, next);
}

module.exports = { 
  productCreateDTO,
}