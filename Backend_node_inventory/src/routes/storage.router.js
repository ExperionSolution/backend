const express = require('express');
const router = express.Router();
const storageController = require('../controllers/storage.controllers');

router.get('/', storageController.get);
router.get('/:id', storageController.getById);
router.post('/', storageController.create);
router.put('/:id', storageController.update);
router.delete('/:id', storageController.remove);

module.exports = router;