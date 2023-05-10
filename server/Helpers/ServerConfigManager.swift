//
//  Constants.swift
//  IOSVaporHTTPServer
//
//  Created by David Martín Sáiz on 10/5/23.
//

import Foundation

/// Entity for configure server.
struct ServerConfig {
  var baseURL: String
  var host: String
  var port: String
  var basePath: String
  var timeAwake: Double
}

/// This class is used as singleton for configure all settings of Vapor server.
class ServerConfigManager {
  static let shared = ServerConfigManager()
  let config = ServerConfig(baseURL: ProcessInfo().hostName,
                            host: Helpers.Random.randomizeHostIP(),
                            port: Helpers.Random.randomizePort(),
                            basePath: Helpers.Random.randomizePath(),
                            timeAwake: 3000.0) // In seconds.
}
