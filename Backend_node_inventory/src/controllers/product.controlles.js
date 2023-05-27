const ProductService = require('../services/products.service');
const service = new ProductService();
const { handleHttp, handleNotFound } = require('../utils/error.handler');
const { handleCreate, handleSuccess, handleNotContent } = require('../utils/success.handler');

const create = async (req, res) => {
    try{
        const product = await service.create(req.body);
        handleCreate(res, product);
    } catch(err){
        handleHttp(res, 'ERROR_CREATE_PRODUCT', err);
    }

}

const get = async (req, res) => {
    try{
        const products = await service.getAll();
        if(!products?.at(0)) return handleNotContent(res);
        handleSuccess(res, products);
    } catch(err){
        handleHttp(res, 'ERROR_GET_PRODUCT', err);
    }
}

const getById = async (req, res) => {
    try{
        const product = await service.getById(req.params.id);
        if(!product) return handleNotFound(res, 'ERROR_NOT_FOUND_PRODUCT');
        handleSuccess(res, product);
    } catch(err){
        handleHttp(res, 'ERROR_GET_ONE_PRODUCT', err);
    }
}

const update = async (req, res) => {
    try{
        const product = await service.update(req.params.id, req.body);
        handleSuccess(res, product);
    } catch(err){
        handleHttp(res, 'ERROR_UPDATE_PRODUCT', err);
    }
}

const remove = async (req, res) => {
    try{
        const product = await service.delete(req.params.id);
        handleSuccess(res, product);
    } catch(err){
        handleHttp(res, 'ERROR_REMOVE_PRODUCT', err);
    }
}

module.exports = {create, get, getById, update, remove};