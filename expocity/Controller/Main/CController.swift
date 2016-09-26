import UIKit

class CController:UIViewController
{
    weak var layoutLeft:NSLayoutConstraint!
    weak var layoutRight:NSLayoutConstraint!
    weak var shadow:VMainShadow?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override var preferredStatusBarStyle:UIStatusBarStyle
    {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden:Bool
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
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[shadow]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        view.layoutIfNeeded()
    }
}
