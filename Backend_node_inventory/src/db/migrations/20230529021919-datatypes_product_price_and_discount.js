'use strict';
const {ProductSchema, PRODUCT_TABLE} = require('../models/product.model');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface) {
    await queryInterface.changeColumn(PRODUCT_TABLE, 'price', ProductSchema.price);
    await queryInterface.changeColumn(PRODUCT_TABLE, 'discount', ProductSchema.discount);
  },
  async down (queryInterface) {
    await queryInterface.removeColumn(PRODUCT_TABLE, 'price');
    await queryInterface.removeColumn(PRODUCT_TABLE, 'discount');
  }
};
