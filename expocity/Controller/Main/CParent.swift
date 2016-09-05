import UIKit

class CParent:UIViewController
{
    weak var bar:VBar!
    weak var layoutCurrentLeft:NSLayoutConstraint!
    weak var layoutCurrentRight:NSLayoutConstraint!
    weak var current:UIViewController!
    let kBarHeight:CGFloat = 64
    let kBarMinHeight:CGFloat = 20
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    private let kAnimationDuration:NSTimeInterval = 0.3
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let bar:VBar = VBar(parent:self)
        self.bar = bar
        view.addSubview(bar)
        
        let home:CHome = CHome()
        current = home
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
            "V:|-0-[bar(barHeight)]-0-[home]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCurrentLeft = NSLayoutConstraint(
            item:home.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:view,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        layoutCurrentRight = NSLayoutConstraint(
            item:home.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:view,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        
        view.addConstraint(layoutCurrentLeft)
        view.addConstraint(layoutCurrentRight)
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
    
    func push(controller:UIViewController)
    {
        
    }
    
    func scrollLeft(controller:UIViewController)
    {
        let width:CGFloat = view.bounds.maxX
        addChildViewController(controller)
        view.addSubview(controller.view)
        
        UIView.animateWithDuration(<#T##duration: NSTimeInterval##NSTimeInterval#>, animations: <#T##() -> Void#>)
        
        home.didMoveToParentViewController(self)
        
    }
    
    func scrollRight(controller:UIViewController)
    {
        
    }
}