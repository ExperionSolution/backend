const StorageService = require('../services/storage.service');
const service = new StorageService();

const create = async (req, res) => {
    try{
        const storage = await service.create(req.body);
        res.status(201).json(storage);
    } catch(err){
        res.status(400).json(err);
    }

}

const get = async (req, res) => {
    try{
        const storage = await service.getAll();
        res.status(200).json(storage);
    } catch(err){
        res.status(400).json(err);
    }
}

const getById = async (req, res) => {
    try{
        const storage = await service.getById(req.params.id);
        res.status(200).json(storage);
    } catch(err){
        res.status(400).json(err);
    }
}

const update = async (req, res) => {
    try{
        const storage = await service.update(req.params.id, req.body);
        res.status(200).json(storage);
    } catch(err){
        res.status(400).json(err);
    }
}

const remove = async (req, res) => {
    try{
        const storage = await service.delete(req.params.id);
        res.status(200).json(storage);
    } catch(err){
        res.status(400).json(err);
    }
}

module.exports = {create, get, getById, update, remove};