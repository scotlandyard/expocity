import Foundation

class MMenuItemHome:MMenuItem
{
    private let kIconImage:String = "menuSettings"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemHome_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
}