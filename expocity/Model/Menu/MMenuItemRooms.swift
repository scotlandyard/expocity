import UIKit

class MMenuItemRooms:MMenuItem
{
    private let kIconImage:String = "menuRooms"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemRoom_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
    
    override func controller() -> CController
    {
        let controller:coor = CHome()
        
        return controller
    }
}