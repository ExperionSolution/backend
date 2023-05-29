const {Model, DataTypes, Sequelize, UniqueConstraintError} = require('sequelize');
const STORAGE_TABLE = 'storage';

const StorageSchema = {
    id:{
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        unique: true,
        type: DataTypes.INTEGER,
    },
    name:{
        allowNull:false,
        type:DataTypes.STRING,
        unique : true,
        validate: {
            len: [1, 25]
        }
    },
    address:{
        allowNull:false,
        type:DataTypes.STRING,
        validate: {
            len: [1, 25]
        }
    },
    city:{
        allowNull:false,
        type:DataTypes.STRING,
        validate: {
            len: [1, 25]
        }
    },
    phone:{
        allowNull:false,
        type:DataTypes.STRING,
        validate: {
            len: [12, 20]
        }
    },
    email:{
        allowNull:false,
        type:DataTypes.STRING,
    },
    number_of_employees:{
        allowNull:false,
        type:DataTypes.INTEGER,
    },
   
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