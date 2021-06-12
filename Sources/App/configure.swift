import Vapor
import Fluent
import FluentMySQLDriver
import Leaf

/// Called before your application initializes.
public func configure(_ app: Application) throws {

    // Use port 8001
    app.http.server.configuration.port = 8001
    
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    var databaseConfig: MySQLConfiguration
    if app.environment.isRelease {
        databaseConfig = MySQLConfiguration(hostname: Environment.get("JAWSDB_URL")!,
                                            port: Int(Environment.get("JAWSDB_PORT")!)!,
                                            username: Environment.get("JAWSDB_USERNAME")!,
                                            password: Environment.get("JAWSDB_PASSWORD")!,
                                            database: Environment.get("JAWSDB_DATABASE")!)
    } else {
        databaseConfig = MySQLConfiguration(hostname: "127.0.0.1",
                                            port: 3306,
                                            username: "root",
                                            password: "root",
                                            database: "exchanges_database",
                                            tlsConfiguration: .forClient(certificateVerification: .none))

    }

    app.databases.use(.mysql(configuration: databaseConfig), as: .mysql)
    
    app.migrations.add(ExchangeRateResponseTO())

    try routes(app)
}
