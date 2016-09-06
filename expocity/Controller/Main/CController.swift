import UIKit

class CController:UIViewController
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var shadow:VMainShadow?
    
    deinit
    {
        print("dealloc")
    }
    
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
    
    //MARK: public
    
    func addShadow()
    {
        let shadow:VMainShadow = VMainShadow()
        self.shadow = shadow
        
        view.addSubview(shadow)
        
        let views:[String:AnyObject] = [
            "shadow":shadow]
        
        let metrics:[String:AnyObject] = [:]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        shadow.layoutIfNeeded()
    }
}