//
//  ViewController.swift
//  PushNotifsTest
//
//  Created by Blake Tsuzaki on 2/15/17.
//  Copyright © 2017 Modoki. All rights reserved.
//
/**
 Ohai
 */
import UIKit
import UserNotifications
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var registerForPushButton: UIButton!
    @IBOutlet weak var sendPushButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0. Boilerplate stuff
        registerForPushButton.addTarget(self, action: #selector(tryRegisterForPushNotifs), for: .touchUpInside)
        sendPushButton.addTarget(self, action: #selector(trySendPushNotif), for: .touchUpInside)
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            self.sendPushButton.isHidden = settings.authorizationStatus != .authorized
        }
        
        // 1. Initialize the Parse client SDK and your application's parameters.
        //    Note that as of iOS 9, your backend must support SSL
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration) in
            configuration.applicationId = "pushnotifstest"
            configuration.server = "https://pushnotifstest.herokuapp.com/parse"
        }))
    }
    
    func tryRegisterForPushNotifs() {
        
        // 2. Ask the user for permission for the app to display notifications
        //    in general.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            if granted {
                alert.title = "Hooray"
                alert.message = "Push Notifications Enabled"
                self.sendPushButton.isHidden = false
                
                // 3. Now here is where we register for push notifications. It's
                //    a bit of a complicated process as of iOS 10, but it works.
                UIApplication.shared.registerForRemoteNotifications()
                
                // [Step 4 located in AppDelegate.swift]

            } else {
                alert.title = "Error"
                alert.message = error == nil ? "Push Notifications Weren't Granted. You can grant permission in the Settings app" : error?.localizedDescription
            }
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // 7. This button action (defined above) calls a Parse Cloud function. For
    //    that, go to http://github.com/Baddaboo/parse-server-example
    func trySendPushNotif() {
        PFCloud.callFunction(inBackground: "sendPush", withParameters: nil)
    }
}

