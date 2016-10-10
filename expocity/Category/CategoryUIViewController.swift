import UIKit

extension UIViewController
{
    var parentController:CParent
    {
        get
        {
            return self.parent as! CParent
        }
    }
}
