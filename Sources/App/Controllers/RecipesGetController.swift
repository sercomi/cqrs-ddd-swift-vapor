import Vapor

final class RecipesGetController: RouteCollection {
    func boot(router: Router) throws {
        
        let recipesRoutes = router.grouped("api", "recipes")
        recipesRoutes.get(use: index)
        recipesRoutes.get(UUID.parameter, use: find)
    }
    
    func index(_ req: Request) throws -> Future<[Recipe]> {
        let repository = try req.make(RecipeRepository.self)
        let searcher = RecipesSearcher(repository)
        
        return searcher.search()
    }
    
    func find(_ req: Request) throws -> Future<Recipe> {
        let id =  try req.parameters.next(UUID.self)
        
        let repository = try req.make(RecipeRepository.self)
        let finder = RecipeFinder(repository)
        
        return try finder.find(id: id)
    }
}
