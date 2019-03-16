import Vapor

final class RecipeUpdater {
    let repository: RecipeRepository
    let finder: RecipeFinder
    
    init(_ repository: RecipeRepository) {
        self.repository = repository
        self.finder = RecipeFinder(repository)
    }
    
    func update(id: RecipeId, title: RecipeTitle) throws {
        _ = try? finder.find(id: id).map { recipe in
            let updateRecipe = Recipe.create(id: id, title: title)
            self.repository.save(updateRecipe)
        }
    }
}
