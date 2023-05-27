'use strict';

const {StorageSchema, STORAGE_TABLE} = require('../models/storage.model');

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface) {
  await queryInterface.addColumn(STORAGE_TABLE, 'city', StorageSchema.city);
  await queryInterface.addColumn(STORAGE_TABLE, 'phone', StorageSchema.phone);
  await queryInterface.addColumn(STORAGE_TABLE, 'email', StorageSchema.email);
  await queryInterface.addColumn(STORAGE_TABLE, 'number_of_employees', StorageSchema.number_of_employees);
    
   
  },

  async down (queryInterface) {
    await queryInterface.removeColumn(STORAGE_TABLE, 'city');
    await queryInterface.removeColumn(STORAGE_TABLE, 'phone');
    await queryInterface.removeColumn(STORAGE_TABLE, 'email');
    await queryInterface.removeColumn(STORAGE_TABLE, 'number_of_employees');

  }
};
