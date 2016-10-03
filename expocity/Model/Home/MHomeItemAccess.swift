import UIKit

class MHomeItemAccess:MHomeItem
{
    private let kCellHeight:CGFloat = 50
    private let kSelectable:Bool = false
    var access:FDatabaseModelRoom.Access
    
    init()
    {
        access = FDatabaseModelRoom.Access.invitationOnly
        let reusableIdentifier:String = VHomeCellAccess.reusableIdentifier()
        super.init(cellHeight:kCellHeight, reusableIdentifier:reusableIdentifier, selectable:kSelectable)
    }
}
