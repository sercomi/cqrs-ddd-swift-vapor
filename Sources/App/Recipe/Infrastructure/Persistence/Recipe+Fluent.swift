import Vapor
import FluentSQLite

extension Recipe: Content {}
extension Recipe: SQLiteUUIDModel {}
extension Recipe: Migration {}
extension Recipe: Parameter {}
