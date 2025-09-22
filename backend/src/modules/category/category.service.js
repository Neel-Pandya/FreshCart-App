import Category from './category.model.js';

class CategoryService {
  async addCategory(name) {
    const existingCategory = Category.find({ $where: { name: name } });
    if (existingCategory.length > 0) {
      throw new Error('Category already exists');
    }

    const newCategory = Category.create({ name });
    return newCategory;
  }

  async getAllCategories() {
    return await Category.find();
  }

  async deleteCategory(id) {
    return await Category.findByIdAndDelete(id);
  }

  async updateCategory(id, name) {
    return await Category.findByIdAndUpdate(id, { name }, { new: true, runValidators: true });
  }
}

export default new CategoryService();
