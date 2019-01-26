import Vapor
import FluentMySQL
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Use port 8001
    let myService = NIOServerConfig.default(port: 8001)
    services.register(myService)

    try services.register(FluentMySQLProvider())
    try services.register(LeafProvider())

    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    var databases = DatabasesConfig()
    var databaseConfig: MySQLDatabaseConfig
    if env.isRelease {
        databaseConfig = MySQLDatabaseConfig(hostname: Environment.get("JAWSDB_URL")!,
                                             port: Int(Environment.get("JAWSDB_PORT")!)!,
                                             username: Environment.get("JAWSDB_USERNAME")!,
                                             password: Environment.get("JAWSDB_PASSWORD")!,
                                             database: Environment.get("JAWSDB_DATABASE")!)
    } else {
        databaseConfig = MySQLDatabaseConfig(hostname: "127.0.0.1",
                                                 port: 3306,
                                                 username: "root",
                                                 password: "root",
                                                 database: "vydaje",
                                                 transport: MySQLTransportConfig.unverifiedTLS)

    }
    let database = MySQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .mysql)
    services.register(databases)

    var migrations = MigrationConfig()
    migrations.add(model: ExchangeRateResponseTO.self, database: .mysql)
    services.register(migrations)
}
