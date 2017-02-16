//
//  ┌──┐ ┌──┐┌──────┐┌──┐ ┌──┐
//  │  │ │  ││  ┌───┘│  │ │  │
//  │  └─┘  ││  └───┐│  └─┘  │
//  │  ┌─┐  ││  ┌───┘└──┐  ┌─┘
//  │  │ │  ││  └───┐   │  │
//  └──┘ └──┘└──────┘   └──┘ ... Stop right there! If you haven't gone through
//                               steps 0-3, go back to ViewController.swift
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    // 4. Implement this delegate function to save the phone's device token to
    //    Parse. Note that PFInstallation.saveInBackground() happens
    //    asynchronously, so don't try to push right after this delegate
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground()
    }
    
    // 5. Before you move on, make sure that you have enabled Push Notifications
    //    in the target's entitlements section. Go to:
    //
    //          PushNotifsTest -> Capabilities
    //
    //     and ensure that these settings are enabled:
    //
    //          Push Notifications
    //          Background Modes -> Remote Notifications
    //
    // 6. Simply implement this function to ensure that the Parse SDK handles
    //    your push notification (typically while in-app)
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PFPush.handle(userInfo)
    }
    // [Step 7 located in ViewController.swift]
}
