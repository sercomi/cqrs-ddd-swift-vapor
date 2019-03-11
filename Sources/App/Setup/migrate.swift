import Vapor
import FluentSQLite

public func migrate(migrations: inout MigrationConfig) throws {
    migrations.add(model: Recipe.self, database: .sqlite)
}
