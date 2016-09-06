import UIKit

class MHomeItemCreate:MHomeItem
{
    private let kCellHeight:CGFloat = 50
    private let kSelectable:Bool = true
    
    init()
    {
        let reusableIdentifier:String = VHomeCellCreate.reusableIdentifier()
        super.init(cellHeight:kCellHeight, reusableIdentifier:reusableIdentifier, selectable:kSelectable)
    }
}