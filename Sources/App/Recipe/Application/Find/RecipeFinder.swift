import Vapor

final class RecipeFinder {
    let repository: RecipeRepository
    
    init(_ repository: RecipeRepository) {
        self.repository = repository
    }
    
    func find(id: RecipeId) throws -> Future<Recipe> {
        
        return repository.find(id: id).map { recipe in
            guard let recipe = recipe else {
                throw Abort(.notFound)
            }
            
            return recipe
        }
    }
}
