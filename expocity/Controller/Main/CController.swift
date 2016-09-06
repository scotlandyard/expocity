import UIKit

class CController:UIViewController
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge.None
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle
    {
        return UIStatusBarStyle.LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return false
    }
}