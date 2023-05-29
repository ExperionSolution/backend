const express = require('express');
const router = express.Router();
const storageController = require('../controllers/storage.controllers');
const { storageCreateDTO } = require('../dto/storage.dto/storage.dto');

router.get('/', storageController.get);
router.get('/:id', storageController.getById);
router.post('/', storageCreateDTO, storageController.create);
router.put('/:id', storageController.update);
router.delete('/:id', storageController.remove);

module.exports = router;