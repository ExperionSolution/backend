const {Model, DataTypes, Sequelize} = require('sequelize');
const {STORAGE_TABLE}=require('./storage.model')
const PRODUCT_TABLE = 'product';


const ProductSchema = {
    id:{
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
        unique: true,
    },
    
    user_id:{
        allowNull: false,
        type: DataTypes.INTEGER,
    },

    category_id:{
        allowNull: false,
        type: DataTypes.INTEGER,
    },
    
    name:{
        allowNull: false,
        type: DataTypes.STRING,
        unique: true,
    },
   
    description:{
        allowNull: false,
        type: DataTypes.STRING,
    },

    code :{
        allowNull: false,
        type: DataTypes.STRING,
        unique: true,
    },

    price :{
        allowNull: false,
        type: DataTypes.INTEGER,
    },
    quantity:{
        allowNull: true,
        type: DataTypes.INTEGER,

    },
    discount :{
        allowNull: false,
        type: DataTypes.INTEGER,
    },
    image :{
        allowNull: false,
        type: DataTypes.STRING,
    },
    created_at:{
        allowNull: false,
        type: DataTypes.DATE,
        defaultValue: Sequelize.NOW,
    },
    updated_at:{
        allowNull: false,
        type: DataTypes.DATE,
        defaultValue: Sequelize.NOW,
    },
    deleted_at:{
        allowNull: true,
        type: DataTypes.DATE,
        
    },
    storage_id:{
        allowNull: true,
        type: DataTypes.INTEGER,
        unique: false,
        references: {
            model: STORAGE_TABLE,
            key: 'id'
         },
         onUpdate: 'CASCADE',
         onDelete: 'SET NULL',
    },
};

class Product extends Model{
    static associate(models){
     this.belongsTo(models.Storage, {foreignKey: 'storage_id', as: 'storage'})
    } 

    static config(sequelize){
        return {
            sequelize,
            tableName: PRODUCT_TABLE,
            modelName: 'Product',
            timestamps: false,
        }
    }
}

module.exports = {ProductSchema, Product, PRODUCT_TABLE};