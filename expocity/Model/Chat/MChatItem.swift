import UIKit

class MChatItem
{
    let reusableIdentifier:String
    var cellWidth:CGFloat
    var cellHeight:CGFloat
    
    init(reusableIdentifier:String)
    {
        self.reusableIdentifier = reusableIdentifier
        cellWidth = 0
        cellHeight = 0
    }
}