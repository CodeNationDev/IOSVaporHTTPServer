//
//  URL+Extensions.swift
//  IOSVaporHTTPServer
//
//  Created by David Martín Sáiz on 10/5/23.
//

import Foundation

extension URL {

  /// Sandbox app documents directory
  /// - Returns: document directory path as URL
  static func documentsDirectory() throws -> URL {
    try FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: false)
  }

  /// Visible files into URL directory
  /// - Returns: URL Array of all visible contents.
  func visibleContents() throws -> [URL] {
    try FileManager.default.contentsOfDirectory(
      at: self,
      includingPropertiesForKeys: nil,
      options: .skipsHiddenFiles)
  }
}
