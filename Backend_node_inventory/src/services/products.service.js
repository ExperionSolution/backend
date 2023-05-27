const { models } = require('../libs/sequelize');

class ProductService {
    constructor() {

        this.model = models.Product;

    }

    async getAll() {
        return await this.model.findAll({
            include: [{ model: models.Storage, as: 'storage' }]
        });
    }

    async getById(id) {
        return await this.model.findByPk(id, {
            include: [{ model: models.Storage, as: 'storage' }]
        });
    }

    async create(data) {
        return await this.model.create(data);
    }

    async update(id, data) {
        const product = await this.getById(id);
        return await product.update(data);
    }

    async delete(id) {
        const product = await this.getById(id);
        return await product.destroy();
    }
}

module.exports = ProductService;