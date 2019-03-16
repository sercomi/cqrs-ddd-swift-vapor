import Vapor

protocol RecipeRepository {
    func all() -> Future<[Recipe]>
    func create(_ recipe: Recipe)
    func find(id: RecipeId) -> Future<Recipe?>
    func save(_ recipe: Recipe)
}
