import Foundation

final class RecipeCreator {
    let repository: RecipeRepository
    
    init(_ repository: RecipeRepository) {
        self.repository = repository
    }
    
    func create(id: RecipeId, title: RecipeTitle) {
        let recipe = Recipe.create(id: id, title: title)
        repository.create(recipe)
    }
}
