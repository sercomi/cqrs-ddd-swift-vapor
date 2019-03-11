import Foundation

final class Recipe: Codable {
    var id: RecipeId?
    var title: RecipeTitle
    
    init(id: RecipeId?, title: RecipeTitle) {
        self.id = id
        self.title = title
    }
    
    static func create(id: RecipeId?, title: RecipeTitle) -> Recipe {
        return Recipe(id: id, title: title)
    }
}
