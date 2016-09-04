import UIKit

class CParent:UIViewController
{
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let home:CHome = CHome()
        addChildViewController(home)
        view.addSubview(home.view)
        home.didMoveToParentViewController(self)
        
        let views:[String:AnyObject] = [
            "home":home.view]
        
        let metrics:[String:AnyObject] = [:]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[home]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[home]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return false
    }
    
    //MARK: public
    
    func statusBarLight()
    {
        statusBarStyle = UIStatusBarStyle.LightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func statusBarDefault()
    {
        statusBarStyle = UIStatusBarStyle.Default
        setNeedsStatusBarAppearanceUpdate()
    }
}