//
//  ServerRouteCollection.swift
//  IOSVaporHTTPServer
//
//  Created by David Martín Sáiz on 9/5/23.
//

import Vapor

struct ServerRouteCollection: RouteCollection {
  /// Declare entrypoints for API.
  /// - Parameter routes: route builder for server API.
  func boot(routes: RoutesBuilder) throws {
    routes.get("\(ServerConfigManager.shared.config.basePath)", use: landing)
    routes.get(":fileName", use: install)
  }

  /// Func for create the view and params for landing page that callbacks the cert download.
  /// - Parameter request: vapor Request.
  /// - Returns: View rendered for landign page.
  func landing(request: Request) async throws -> View {
    let documentsDirectory = try URL.documentsDirectory()
    let fileUrls = try documentsDirectory.visibleContents()
    let filenames = fileUrls.map { $0.lastPathComponent }
    guard let fileName = filenames.first else {
      return try await request.view.render("error",
                                           ErrContext(errorTitle: Abort(.internalServerError).debugDescription))
    }
    let context = Context(fileName: fileName)
    return try await request.view.render("landing", context)
  }

  /// Function for install certificate.
  /// - Parameter request: Vapor Request.
  /// - Returns: Vapor Respobnse with file stream for download certificate.
  func install(request: Request) throws -> Response {
    guard let filename = request.parameters.get("fileName") else {
      throw Abort(.badRequest)
    }
    let fileUrl = try URL.documentsDirectory().appendingPathComponent(filename)
    return request.fileio.streamFile(at: fileUrl.path)
  }

  /// Entity that contains the filename of certificate for send to landingpage.
  struct Context: Encodable {
    var fileName: String
  }

  /// Entity that contains the error info if anything fails. For error page.
  struct ErrContext: Encodable {
    var errorTitle: String
  }
}
