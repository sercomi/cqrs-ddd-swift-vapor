import Vapor

final class RecipesController: RouteCollection {
    func boot(router: Router) throws {
        
        let recipesRoutes = router.grouped("api", "recipes")
        recipesRoutes.get(use: index)
        recipesRoutes.get(UUID.parameter, use: find)
        recipesRoutes.post( use: create)
        recipesRoutes.put(UUID.parameter, use: update)
        recipesRoutes.delete(UUID.parameter, use: delete)
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
    
    func delete(_ req: Request) throws -> HTTPStatus {
        let id = try req.parameters.next(UUID.self)
        
        let repository = try req.make(RecipeRepository.self)
        let deleter = RecipeDeleter(repository)
        
        try deleter.delete(id: id)
        
        return HTTPStatus.ok
    }
}

struct RecipeRequest: Codable {
    let title: String
}
