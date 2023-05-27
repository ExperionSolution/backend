'use strict';

const {ProductSchema, PRODUCT_TABLE} = require('../models/product.model');
const {StorageSchema, STORAGE_TABLE} = require('../models/storage.model');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface) {
    await queryInterface.createTable(PRODUCT_TABLE, ProductSchema);
    await queryInterface.createTable(STORAGE_TABLE, StorageSchema);
  },

  async down (queryInterface) {
    await queryInterface.dropTable(PRODUCT_TABLE);
    await queryInterface.dropTable(STORAGE_TABLE);
  }
};
