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
  created_at: Joi.date().required(),
  updated_at: Joi.date().required(),
  deleted_at: Joi.date().optional(),
});


module.exports = {
  productCreateValidation,
};
