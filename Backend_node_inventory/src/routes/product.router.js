const express = require('express');
const router = express.Router();
const productController = require('../controllers/product.controlles');
const { productCreateDTO } = require('../dto/products.dto/products.dto')

router.get('/', productController.get);
router.get('/:id', productController.getById);
router.post('/', productCreateDTO, productController.create);
router.put('/:id', productController.update);
router.delete('/:id', productController.remove);

module.exports = router;