const { Product, ProductSchema } = require('./product.model');
const { Storage, StorageSchema } = require('./storage.model');

function setupModels(sequelize){
    Product.init(ProductSchema, Product.config(sequelize));
    Storage.init(StorageSchema, Storage.config(sequelize));
    
    Product.associate(sequelize.models);
    Storage.associate(sequelize.models);
}

module.exports =  setupModels ;