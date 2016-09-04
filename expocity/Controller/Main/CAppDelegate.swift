import UIKit

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate
{
    var window:UIWindow?
    private weak var parent:CParent!
    
    func application(application:UIApplication, didFinishLaunchingWithOptions launchOptions:[NSObject:AnyObject]?) -> Bool
    {
        let window:UIWindow = UIWindow(frame:UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        
        let parent:CParent = CParent()
        window.rootViewController = parent
        self.window = window
        
        return true
    }
}