import Vapor
import FluentSQLite

final class RecipeRepositorySQLite: RecipeRepository {
    
    let db: SQLiteDatabase.ConnectionPool
    
    init(_ db: SQLiteDatabase.ConnectionPool) {
        self.db = db
    }
    
    func all() -> EventLoopFuture<[Recipe]> {
        return db.withConnection { conn in
            return Recipe.query(on: conn).all()
        }
    }
    
    func create(_ recipe: Recipe) {
        _ = db.withConnection { conn in
            return recipe.create(on: conn)
        }
    }
    
    func find(id: RecipeId) -> EventLoopFuture<Recipe?> {
        return db.withConnection { conn in
            return Recipe.find(id, on: conn)
        }
    }
    
    func save(_ recipe: Recipe) {
        _ = db.withConnection { conn in
            return recipe.save(on: conn)
        }
    }
    
    func delete(_ recipe: Recipe) {
        _ = db.withConnection { conn in
            return recipe.delete(on: conn)
        }
    }
}

extension RecipeRepositorySQLite: ServiceType {
    static let serviceSupports: [Any.Type] = [RecipeRepository.self]
    
    static func makeService(for container: Container) throws -> Self {
        return .init(try container.connectionPool(to: .sqlite))
    }
}

extension Database {
    public typealias ConnectionPool = DatabaseConnectionPool<ConfiguredDatabase<Self>>
}
