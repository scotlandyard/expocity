import UIKit

class CParent:UIViewController
{
    weak var bar:VBar!
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    let kBarHeight:CGFloat = 64
    let kBarMinHeight:CGFloat = 20
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let bar:VBar = VBar(parent:self)
        self.bar = bar
        view.addSubview(bar)
        
        let home:CHome = CHome()
        addChildViewController(home)
        view.addSubview(home.view)
        home.didMoveToParentViewController(self)
        
        let views:[String:AnyObject] = [
            "home":home.view,
            "bar":bar]
        
        let metrics:[String:AnyObject] = [
            "barHeight":kBarHeight]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[home]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[bar(barHeight)]-0-[home]-0-|",
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