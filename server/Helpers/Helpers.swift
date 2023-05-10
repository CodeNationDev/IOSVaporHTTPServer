//
//  String+Randomize.swift
//  IOSVaporHTTPServer
//
//  Created by David Martín Sáiz on 10/5/23.
//

import Foundation


/// Entity for unify helpers.
struct Helpers {

  /// Entity for unify randomizations tasks.
  struct Random {

    /// Function for generate random IP.
    /// - Returns: String in IP format: 88.23.45.125 taking into account reserved ports.
    static func randomizeHostIP() -> String {
      var ipAddress = ""
      for _ in 1...4 {
        let octet = Int.random(in: 1...255)
        ipAddress += "\(octet)."
      }
      // Eliminar el último punto
      ipAddress.removeLast()
      return ipAddress
    }

    /// Function for generate random ports.
    /// - Returns: String represented random port: 4556
    static func randomizePort() -> String {
        var port = 0
        repeat {
            port = Int.random(in: 1024...65535)
        } while isPortReserved(port)
        return "\(port)"
    }

    /// Function for generate 10 sized string name for path
    /// - Returns: random String: wdDkLmEdrP
    static func randomizePath() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var path = ""
        for _ in 0..<10 {
            let randomIndex = Int.random(in: 0..<letters.count)
            let letter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            path += String(letter)
        }
        return path
    }

    /// Function for get reserved ports
    /// - Parameter port: Int represented port.
    /// - Returns: Boolean request if port is reserved.
    private static func isPortReserved(_ port: Int) -> Bool {
        let reservedPorts = [20, 21, 22, 23, 25, 53, 80, 110, 143, 443, 587, 993, 995, 3306, 8080]
        return reservedPorts.contains(port)
    }
  }
}


