import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    var controllers:[CController]
    private var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.LightContent
    private let kAnimationDuration:NSTimeInterval = 0.3
    
    init()
    {
        controllers = []
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let home:CHome = CHome()
        center(home)
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
    
    func push(controller:CController)
    {
        addChildViewController(controller)
        
        viewParent.push(controller)
        {
            self.controllers.append(controller)
            controller.didMoveToParentViewController(self)
        }
    }
    
    func center(controller:CController)
    {
        addChildViewController(controller)
        viewParent.over(controller, underBar:true)
        controllers.append(controller)
        controller.didMoveToParentViewController(self)
    }
    
    func over(controller:CController)
    {
        addChildViewController(controller)
        viewParent.over(controller, underBar:false)
        controllers.append(controller)
        controller.didMoveToParentViewController(self)
    }
    
    func pop()
    {
        viewParent.pop()
        {
            let controller:CController = self.controllers.popLast()!
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    func dismiss()
    {
        let controller:CController = controllers.popLast()!
        controller.view.removeFromSuperview()
        controller.removeFromParentViewController()
    }
    
    func scrollLeft(controller:CController)
    {
        addChildViewController(controller)
        controllers.last?.willMoveToParentViewController(nil)
        
        viewParent.fromLeft(controller)
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
            self.controllers.append(controller)
            controller.didMoveToParentViewController(self)
        }
    }
    
    func scrollRight(controller:CController)
    {
        addChildViewController(controller)
        controllers.last?.willMoveToParentViewController(nil)
        
        viewParent.fromRight(controller)
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
            self.controllers.append(controller)
            controller.didMoveToParentViewController(self)
        }
    }
}