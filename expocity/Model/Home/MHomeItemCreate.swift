import UIKit

class MHomeItemCreate:MHomeItem
{
    fileprivate let kCellHeight:CGFloat = 50
    fileprivate let kSelectable:Bool = true
    
    init()
    {
        let reusableIdentifier:String = VHomeCellCreate.reusableIdentifier()
        super.init(cellHeight:kCellHeight, reusableIdentifier:reusableIdentifier, selectable:kSelectable)
    }
}
