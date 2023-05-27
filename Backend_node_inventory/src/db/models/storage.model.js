const {Model, DataTypes, Sequelize, UniqueConstraintError} = require('sequelize');
const STORAGE_TABLE = 'storage';

const StorageSchema = {
    id:{
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
    },
    name:{
        allowNull:false,
        type:DataTypes.STRING,
    },
    address:{
        allowNull:false,
        type:DataTypes.STRING,
    }
   
};

class Storage extends Model{
    static associate(models){
        this.hasMany(models.Product,{
            foreignKey: 'storage_id',
            as: 'products',
        });
        
    } 

    static config(sequelize){
        return {
            sequelize,
            tableName: STORAGE_TABLE,
            modelName: 'Storage',
            timestamps: false,
        }
    }
}

module.exports = {StorageSchema, Storage,STORAGE_TABLE};