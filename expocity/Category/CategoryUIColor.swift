import UIKit

extension UIColor
{
    class func main() -> UIColor //158BC2
    {
        return UIColor(red:0.08235294117647, green:0.54509803921569, blue:0.76078431372549, alpha:1)
    }
    
    class func complement() -> UIColor //62CDF0
    {
        return UIColor(red:0.3843137254902, green:0.80392156862745, blue:0.94117647058824, alpha:1)
    }
    
    class func collectionBackground() -> UIColor
    {
        return UIColor(red:0.90588235294118, green:0.95294117647059, blue:0.97254901960784, alpha:1)
    }
}