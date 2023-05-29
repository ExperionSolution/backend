const Joi = require('joi');

const storageCreateValidation = Joi.object({
  name: Joi.string().min(1).max(25).required(),
  address: Joi.string().min(1).max(25).required(),
  city: Joi.string().min(1).max(25).required(),
  phone: Joi.string().min(12).max(20).required(),
  email: Joi.string().email().required(),
  number_of_employees: Joi.number().integer().required(),
})

module.exports = {
  storageCreateValidation,
};