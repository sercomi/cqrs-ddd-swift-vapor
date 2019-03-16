import Vapor

public func middlewares(config: inout MiddlewareConfig) throws {
    var middlewares = MiddlewareConfig()
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self)
}
