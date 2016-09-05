import UIKit

class VHome:UIView
{
    weak var controller:CHome!
    weak var loader:VMainLoader!
    
    convenience init(controller:CHome)
    {
        self.init()
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        userInteractionEnabled = false
        self.controller = controller
        
        let loader:VMainLoader = VMainLoader()
        self.loader = loader
        
        addSubview(loader)
        
        let views:[String:AnyObject] = [
            "loader":loader]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}