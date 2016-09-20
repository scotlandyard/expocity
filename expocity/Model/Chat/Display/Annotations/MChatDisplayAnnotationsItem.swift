import UIKit

class MChatDisplayAnnotationsItem
{
    var text:String
    var xPos:CGFloat
    var yPos:CGFloat
    
    init()
    {
        text = ""
        xPos = 0
        yPos = 0
    }
    
    init(text:String, xPos:CGFloat, yPos:CGFloat)
    {
        self.text = text
        self.xPos = xPos
        self.yPos = yPos
    }
    
    //MARK: public
    
    func moveToPoint(point:CGPoint)
    {
        xPos = point.x
        yPos = point.y
    }
}