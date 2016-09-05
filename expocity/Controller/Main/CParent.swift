import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    weak var current:UIViewController?
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    private let kAnimationDuration:NSTimeInterval = 0.3
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let home:CHome = CHome()
        current = home
        addChildViewController(home)
        viewParent.center(home)
        home.didMoveToParentViewController(self)
    }
    
    override func loadView()
    {
        let viewParent:VParent = VParent(parent:self)
        self.viewParent = viewParent
        view = viewParent
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
        addChildViewController(controller)
        current?.willMoveToParentViewController(nil)
        
        viewParent.fromLeft(controller)
        {
            self.current?.didMoveToParentViewController(nil)
            self.current = controller
            self.current!.didMoveToParentViewController(self)
        }
    }
    
    func scrollRight(controller:UIViewController)
    {
        addChildViewController(controller)
        current?.willMoveToParentViewController(nil)
        
        viewParent.fromRight(controller)
        {
            self.current?.didMoveToParentViewController(nil)
            self.current = controller
            self.current!.didMoveToParentViewController(self)
        }
    }
}