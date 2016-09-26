import UIKit

extension UIViewController
{
    var parent:CParent
    {
        get
        {
            return self.parent as! CParent
        }
    }
}
