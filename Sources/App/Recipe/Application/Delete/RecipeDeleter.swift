import Vapor

final class RecipeDeleter {
    let repository: RecipeRepository
    let finder: RecipeFinder
    
    init(_ repository: RecipeRepository) {
        self.repository = repository
        self.finder = RecipeFinder(repository)
    }
    
    func delete(id: RecipeId) throws {
        _ = try? finder.find(id: id).map { recipe in
            self.repository.delete(recipe)
        }
    }
}
