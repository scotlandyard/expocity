import Foundation

class MMenuItemRoom:MMenuItem
{
    private let kIconImage:String = "menuSettings"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemRoom_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
}