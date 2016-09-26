import UIKit

extension UIViewController
{
    override var parentController:CParent
    {
        get
        {
            return self.parent as! CParent
        }
    }
}
