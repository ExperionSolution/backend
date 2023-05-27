const Joi = require('joi');

const productCreateValidation = Joi.object({
  user_id: Joi.number().required(),
  category_id: Joi.number().required(),
  name: Joi.string().required(),
  description: Joi.string().required(),
  code: Joi.string().required(), 
  price: Joi.number().required(),
  discount: Joi.number().required(),
  image: Joi.string().required(),
  quantity: Joi.number().required(),
  storage_id: Joi.number().required(),

 
});


module.exports = {
  productCreateValidation,
};
