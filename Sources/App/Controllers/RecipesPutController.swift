import Vapor

final class RecipesPutController: RouteCollection {
    func boot(router: Router) throws {
        
        let recipesRoutes = router.grouped("api", "recipes")
        recipesRoutes.put(UUID.parameter, use: update)
    }
    
    func update(_ req: Request) throws -> HTTPStatus {
        
        _ = try req.content.decode(RecipeRequest.self).map { recipeRequest in
            let id = try req.parameters.next(UUID.self)
            
            let repository = try req.make(RecipeRepository.self)
            let updater = RecipeUpdater(repository)
            let recipeTitle = RecipeTitle(recipeRequest.title)
            
            try updater.update(id: id, title: recipeTitle)
            
        }
        return HTTPStatus.ok
    }
}
