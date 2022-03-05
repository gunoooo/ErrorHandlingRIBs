import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var rib = { () -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate) in
        let rib = AppBuilder().build(withWindow: self.window)
        rib.routing.activate()
        rib.routing.load()
        return rib
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        return rib.lifecycleDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}
