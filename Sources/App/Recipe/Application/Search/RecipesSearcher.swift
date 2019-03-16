import Vapor

final class RecipesSearcher {
    let repository: RecipeRepository
    
    init(_ repository: RecipeRepository) {
        self.repository = repository
    }
    
    func search() -> Future<[Recipe]> {
        return repository.all()
    }
}
