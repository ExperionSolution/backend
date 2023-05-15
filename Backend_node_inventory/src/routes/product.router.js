const express = require('express');
const router = express.Router();
const productController = require('../controllers/product.controlles');

router.get('/', productController.get);
router.get('/:id', productController.getById);
router.post('/', productController.create);
router.put('/:id', productController.update);
router.delete('/:id', productController.remove);

module.exports = router;