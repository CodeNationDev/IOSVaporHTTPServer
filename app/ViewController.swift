//
//  ViewController.swift
//  IOSVaporHTTPServer
//
//  Created by David Martín Sáiz on 9/5/23.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var label: UILabel!
  var server: VaporServer?
  @IBAction func tapLaunchSafariVC(_ sender: Any) {
    server?.launchInstallation()
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    server = VaporServer()
    server?.start()
    label.text = ServerConfigManager.shared.config.baseURL
  }
}

