import UIKit

class MChatDisplayAnnotationsItem
{
    let text:String
    let xPos:CGFloat
    let yPos:CGFloat
    
    init(text:String, xPos:CGFloat, yPos:CGFloat)
    {
        self.text = text
        self.xPos = xPos
        self.yPos = yPos
    }
}