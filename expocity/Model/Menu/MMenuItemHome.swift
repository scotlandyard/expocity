import Foundation

class MMenuItemHome:MMenuItem
{
    private let kIconImage:String = "menuSettings"
    
    init(index:Int)
    {
        super.init(iconImage:kIconImage, index:index)
    }
}