import UIKit

extension UIColor
{
    class func main() -> UIColor
    {
        return UIColor(red:0.94901960784314, green:0.6078431372549, blue:0.18823529411765, alpha:1)
    }
    
    class func complement() -> UIColor
    {
        return UIColor(red:0.94901960784314, green:0.32156862745098, blue:0.18039215686275, alpha:1)
    }
    
    class func collectionBackground() -> UIColor
    {
        return UIColor(white:0.975, alpha:1)
    }
}