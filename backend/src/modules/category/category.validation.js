import {z} from "zod"
const addCategoryValidation = z.strictObject({
    name: z.string({error: 'Category is required'}).nonempty({error: 'Category is required'}).min(3, {error: 'Category must be at least 3 characters long'}).max(100, {error: 'Category must be at most 100 characters long'}).regex(/^[a-zA-Z0-9 ]+$/, {error: 'Category must contain only letters, numbers, and spaces'})
})

const updateCategoryValidation = z.strictObject({
    id: z.string({error: 'Category ID is required'}).nonempty({error: 'Category ID is required'}),
    name: z.string({error: 'Category is required'}).nonempty({error: 'Category is required'}).min(3, {error: 'Category must be at least 3 characters long'}).max(100, {error: 'Category must be at most 100 characters long'}).regex(/^[a-zA-Z0-9 ]+$/, {error: 'Category must contain only letters, numbers, and spaces'})
})

const deleteCategoryValidation = z.strictObject({
    id: z.string({error: 'Category ID is required'}).nonempty({error: 'Category ID is required'})
}) 

export {
    addCategoryValidation,
    updateCategoryValidation,
    deleteCategoryValidation
}