import Vapor

final class RecipesPostController: RouteCollection {
    func boot(router: Router) throws {
        
        let recipesRoutes = router.grouped("api", "recipes")
        recipesRoutes.post( use: create)
    }
    
    func create(_ req: Request) throws -> HTTPStatus {
        _ = try? req.content.decode(RecipeRequest.self).map { recipeRequest in
            
            let repository = try req.make(RecipeRepository.self)
            let creator = RecipeCreator(repository)
            
            let recipeId = RecipeId()
            let recipeTitle = RecipeTitle(recipeRequest.title)
            
            creator.create(id: recipeId, title: recipeTitle)
        }
        
        return HTTPStatus.created
    }
    
}
