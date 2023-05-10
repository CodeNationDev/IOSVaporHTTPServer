//
//  VaporServer.swift
//  IOSVaporHTTPServer
//
//  Created by David Martín Sáiz on 9/5/23.
//

import Foundation
import Vapor
import Leaf
import SafariServices

/// Main entity of Vapor WebServer.
class VaporServer {
  var app: Application
  var port: Int

  // MARK: Lifecycle

  init() {
    self.app = Application(.development)
    self.port = Int(ServerConfigManager.shared.config.port) ?? 0
    configure(app)
  }

  // MARK: Public

  /// Func for start server. Allways must be started in background.
  public func start() {
    Task(priority: .background) {
      do {
       try app.register(collection: ServerRouteCollection())
       try app.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + ServerConfigManager.shared.config.timeAwake) { [weak self] in
          guard let self, let running = app.running  else {
            return
          }
          running.stop()
        }
      } catch let error {
        print(error.localizedDescription)
      }
    }
  }

  /// Function for send stop command to server.
  public func stop() {
    Task(priority: .background) {
      app.running?.stop()
    }
  }

  /// Function for launch certificate installation through Safari.
  func launchInstallation() {
    if let url = URL(string: "http://"
                     + ServerConfigManager.shared.config.baseURL
                     + ":\(port)"
                     + "/"
                     + ServerConfigManager.shared.config.basePath) {

      UIApplication.shared.open(url)
      }
  }

  // MARK: Private

  /// Configure server
  /// - Parameter app: Vapor App for setup.
  private func configure(_ app: Application) {
    app.http.server.configuration.hostname = ServerConfigManager.shared.config.baseURL
    app.http.server.configuration.port = port
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease
    app.leaf.configuration.rootDirectory = Bundle.main.bundlePath
    app.routes.defaultMaxBodySize = "50MB"
  }
}

