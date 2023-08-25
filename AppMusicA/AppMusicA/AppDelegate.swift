import UIKit
import AVFoundation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window?.makeKeyAndVisible()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            application.beginReceivingRemoteControlEvents()
            becomeFirstResponder()
        } catch {
            print("Error setting up audio session: \(error)")
        }
            return true
        }
}
