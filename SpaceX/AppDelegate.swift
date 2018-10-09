import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.appGray
        let navigationController = UINavigationController(rootViewController: FlightsViewController.instantiate())
        navigationController.setDarkAppearance()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
