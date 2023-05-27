const express = require('express');

const productRouter = require('./product.router');
const storageRouter =require('./storage.router');

function routerApi(app){
    const router = express.Router();
    app.use('/api/v1', router);
    router.use('/products', productRouter);
    router.use('/storage',storageRouter)
}

module.exports = routerApi;