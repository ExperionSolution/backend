const Joi = require('joi');

const productCreateValidation = Joi.object({
  user_id: Joi.number().integer().required(),
  category_id: Joi.number().integer().required(),
  name: Joi.string().trim().min(1).max(30).required(),
  description: Joi.string().trim().min(1).max(130).required(),
  code: Joi.string().trim().required(), 
  price: Joi.number().required(),
  discount: Joi.number().required(),
  image: Joi.string().trim().required(),
  quantity: Joi.number().integer().required(),
  storage_id: Joi.number().integer().required(),
});


module.exports = {
  productCreateValidation,
};
