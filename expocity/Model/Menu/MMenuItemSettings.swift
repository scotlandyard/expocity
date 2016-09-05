import Foundation

class MMenuItemSettings:MMenuItem
{
    private let kIconImage:String = "menuSettings"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemSettings_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
}