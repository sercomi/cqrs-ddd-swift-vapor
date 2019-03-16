import Vapor

public func setupRepositories(services: inout Services, config: inout Config) {
    services.register(RecipeRepositorySQLite.self)
    preferDatabaseRepositories(config: &config)
}

private func preferDatabaseRepositories(config: inout Config) {
    config.prefer(RecipeRepositorySQLite.self, for: RecipeRepository.self)
}
