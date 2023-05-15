import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let userDefaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setUpWindow()        
        logDeviceUUID(event: "applicationDidFinishLaunching")
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        logDeviceUUID(event: "applicationDidBecomeActive")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        logDeviceUUID(event: "applicationWillEnterForeground")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        logDeviceUUID(event: "applicationWillResignActive")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        logDeviceUUID(event: "applicationDidEnterBackground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        logDeviceUUID(event: "applicationWillTerminate")
    }
    
    // MARK: - Private

    private func logDeviceUUID(event: String) {
        // Log in the console
        print(">> \(event) - [\(uuid)]")
        
        // Save to UserDefaults
        var logs: [[String: Any]] = userDefaults.array(forKey: "LifeCycleLogs") as? [[String: Any]] ?? []
        let itemDictionary: [String: Any] = [
            "date": Date(),
            "name": event,
            "deviceUUID": uuid
        ]
        logs.append(itemDictionary)
        userDefaults.set(logs, forKey: "LifeCycleLogs")
    }
    
    private var uuid: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }
    
    private func setUpWindow() {
        let viewController = UIHostingController(rootView: ItemList())
        window?.rootViewController = viewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
