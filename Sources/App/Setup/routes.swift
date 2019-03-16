import Vapor

public func routes(_ router: Router, _ container: Container) throws {
    try router.register(collection: RecipesGetController())
    try router.register(collection: RecipesPostController())
    try router.register(collection: RecipesPutController())
    try router.register(collection: RecipesDeleteController())
}
