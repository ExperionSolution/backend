const ProductService = require('../services/products.service');
const service = new ProductService();

const create = async (req, res) => {
    try{
        const product = await service.create(req.body);
        res.status(201).json(product);
    } catch(err){
        res.status(400).json(err);
    }

}

const get = async (req, res) => {
    try{
        const products = await service.getAll();
        res.status(200).json(products);
    } catch(err){
        res.status(400).json(err);
    }
}

const getById = async (req, res) => {
    try{
        const product = await service.getById(req.params.id);
        res.status(200).json(product);
    } catch(err){
        res.status(400).json(err);
    }
}

const update = async (req, res) => {
    try{
        const product = await service.update(req.params.id, req.body);
        res.status(200).json(product);
    } catch(err){
        res.status(400).json(err);
    }
}

const remove = async (req, res) => {
    try{
        const product = await service.delete(req.params.id);
        res.status(200).json(product);
    } catch(err){
        res.status(400).json(err);
    }
}

module.exports = {create, get, getById, update, remove};