import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var interactor = AppBuilder(dependency: EmptyComponent()).build()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        return interactor.lifecycleDelegate.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}
