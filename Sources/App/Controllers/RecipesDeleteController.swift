import Vapor

final class RecipesDeleteController: RouteCollection {
    func boot(router: Router) throws {
        
        let recipesRoutes = router.grouped("api", "recipes")
        recipesRoutes.delete(use: delete)
    }
    
    func delete(_ req: Request) throws -> HTTPStatus {
        let id = try req.parameters.next(UUID.self)
        
        let repository = try req.make(RecipeRepository.self)
        let deleter = RecipeDeleter(repository)
        
        try deleter.delete(id: id)
        
        return HTTPStatus.ok
    }
}
