const StorageService = require('../services/storage.service');
const { handleNotFound, handleHttp, handleBadRequest } = require('../utils/error.handler');
const { handleNotContent, handleCreate, handleSuccess } = require('../utils/success.handler');
const service = new StorageService();

const create = async (req, res) => {
    try{
        const storage = await service.create(req.body);
        if(!storage) return handleBadRequest(res, 'This storage name already exist.')
        handleCreate(res, storage);
    } catch(err){
        handleHttp(res, 'ERROR_CREATE_STORAGE' ,err);
    }
}

const get = async (req, res) => {
    try{
        const storage = await service.getAll();
        if(!storage.at(0)) return handleNotContent(res)
        handleSuccess(res, storage);
    } catch(err){
        handleHttp(res, 'ERROR_GET_ALL_STORAGE', err);
    }
}

const getById = async (req, res) => {
    try{
        const storage = await service.getById(req.params.id);
        if(!storage) return handleNotFound(res, 'NOT_FOUND_STORAGE')
        handleSuccess(res, storage);
    } catch(err){
        handleHttp(res, 'ERROR_GET_STORAGE', err);
    }
}

const update = async (req, res) => {
    try{
        const storage = await service.update(req.params.id, req.body);
        handleSuccess(res, storage);
    } catch(err){
        handleHttp(res, 'ERROR_UPDATE_STORAGE', err);
    }
}

const remove = async (req, res) => {
    try{
        const storage = await service.delete(req.params.id);
        handleSuccess(res, storage);
    } catch(err){
        handleHttp(res, 'ERROR_REMOVE_STORAGE', err);
    }
}

module.exports = {create, get, getById, update, remove};