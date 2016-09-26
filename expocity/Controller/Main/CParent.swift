import UIKit

class CParent:UIViewController
{
    weak var viewParent:VParent!
    var controllers:[CController]
    fileprivate var statusBarStyle:UIStatusBarStyle = UIStatusBarStyle.lightContent
    fileprivate let kAnimationDuration:TimeInterval = 0.3
    
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
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden : Bool
    {
        return false
    }
    
    //MARK: public
    
    func statusBarLight()
    {
        statusBarStyle = UIStatusBarStyle.lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func statusBarDefault()
    {
        statusBarStyle = UIStatusBarStyle.default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func push(_ controller:CController)
    {
        addChildViewController(controller)
        
        viewParent.push(controller)
        {
            self.controllers.append(controller)
            controller.didMove(toParentViewController: self)
        }
    }
    
    func center(_ controller:CController)
    {
        addChildViewController(controller)
        viewParent.over(controller, underBar:true)
        controllers.append(controller)
        controller.didMove(toParentViewController: self)
    }
    
    func over(_ controller:CController)
    {
        addChildViewController(controller)
        viewParent.over(controller, underBar:false)
        controllers.append(controller)
        controller.didMove(toParentViewController: self)
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
        viewParent.dismiss()
        {
            let controller:CController = self.controllers.popLast()!
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
    }
    
    func scrollLeft(_ controller:CController)
    {
        addChildViewController(controller)
        controllers.last?.willMove(toParentViewController: nil)
        
        viewParent.fromLeft(controller)
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
            self.controllers.append(controller)
            controller.didMove(toParentViewController: self)
        }
    }
    
    func scrollRight(_ controller:CController)
    {
        addChildViewController(controller)
        controllers.last?.willMove(toParentViewController: nil)
        
        viewParent.fromRight(controller)
        {
            let lastController:CController? = self.controllers.popLast()
            lastController?.view.removeFromSuperview()
            lastController?.removeFromParentViewController()
            self.controllers.append(controller)
            controller.didMove(toParentViewController: self)
        }
    }
}
