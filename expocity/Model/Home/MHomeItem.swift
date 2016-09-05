import UIKit

class MHomeItem
{
    let cellHeight:CGFloat
    let reusableIdentifier:String
    let selectable:Bool
    
    init(cellHeight:CGFloat, reusableIdentifier:String, selectable:Bool)
    {
        self.cellHeight = cellHeight
        self.reusableIdentifier = reusableIdentifier
        self.selectable = selectable
    }
}