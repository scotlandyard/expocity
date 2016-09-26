import UIKit

class MHomeItemTitle:MHomeItem
{
    private let kCellHeight:CGFloat = 65
    private let kSelectable:Bool = false
    var title:String
    
    init()
    {
        title = ""
        let reusableIdentifier:String = VHomeCellTitle.reusableIdentifier()
        super.init(cellHeight:kCellHeight, reusableIdentifier:reusableIdentifier, selectable:kSelectable)
    }
}
