const { models } = require('../libs/sequelize');
const { UniqueConstraintError } = require('sequelize/lib/errors');

class StorageService {
    constructor() {
        this.model=models.Storage;
    }

    async getAll() {
        return await this.model.findAll();
    }

    async getById(id) {
        return await this.model.findByPk(id, 
            { include: ['products'] }
            );
    }

    async create(data) {
        const existingStorage = await this.model.findOne({
          where: { name: data.name },
        });
    
        if (existingStorage) {
          throw new UniqueConstraintError({
            message: 'This Storage Already exist.',
            errors: [{ path: 'name', value: data.name }],
            fields: ['name'],
          });
        }
    
        return await this.model.create(data);
      }

    async update(id, data) {
        const storage = await this.getById(id);
        return await storage.update(data);
    }

    async delete(id) {
        const storage = await this.getById(id);
        return await storage.destroy();
    }


   
}

module.exports = StorageService;