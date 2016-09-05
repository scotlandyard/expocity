import UIKit

extension UIViewController
{
    var parent:CParent
    {
        get
        {
            return self.parentViewController as! CParent
        }
    }
}