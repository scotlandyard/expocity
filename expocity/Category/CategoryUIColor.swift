import UIKit

extension UIColor
{
    class func main() -> UIColor
    {
        return UIColor(red:0.08235294117647, green:0.54509803921569, blue:0.76078431372549, alpha:1)
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