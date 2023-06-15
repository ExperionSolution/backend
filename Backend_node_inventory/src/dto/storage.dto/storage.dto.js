const { storageCreateValidation } = require('./validation.storage');
const validateFunction = require('../validation.handler');


const storageCreateDTO = (req, res, next) => {
  validateFunction(storageCreateValidation, req, res, next);
}

module.exports = { 
  storageCreateDTO,
}

