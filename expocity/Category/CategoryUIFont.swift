import UIKit

extension UIFont
{
    class func regular(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Regular", size:size)!
    }
    
    class func medium(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Medium", size:size)!
    }
    
    class func bold(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-DemiBold", size:size)!
    }
    
    class func numeric(_ size:CGFloat) -> UIFont
    {
        return UIFont(name:"AvenirNext-Bold", size:size)!
    }
}
