import Foundation

class MMenuItemHistory:MMenuItem
{
    private let kIconImage:String = "menuSettings"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemHistory_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
}