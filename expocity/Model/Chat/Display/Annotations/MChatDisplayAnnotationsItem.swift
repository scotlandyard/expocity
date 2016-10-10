import UIKit

class MChatDisplayAnnotationsItem
{
    var text:String
    var xPercent:CGFloat
    var yPercent:CGFloat
    
    init()
    {
        text = ""
        xPercent = 0
        yPercent = 0
    }
    
    init(text:String, xPercent:CGFloat, yPercent:CGFloat)
    {
        self.text = text
        self.xPercent = xPercent
        self.yPercent = yPercent
    }
    
    //MARK: public
    
    func moveToPoint(xPercent:CGFloat, yPercent:CGFloat)
    {
        self.xPercent = xPercent
        self.yPercent = yPercent
    }
}
