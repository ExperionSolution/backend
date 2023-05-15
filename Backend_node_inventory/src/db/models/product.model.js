const {Model, DataTypes, Sequelize} = require('sequelize');

const PRODUCT_TABLE = 'product';

const ProductSchema = {
    id:{
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
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
        
    }
};

class Product extends Model{
    static associate(){
        //associate
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

module.exports = {ProductSchema, Product};