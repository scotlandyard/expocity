import Foundation

class MMenuItemHistory:MMenuItem
{
    private let kIconImage:String = "menuSettings"
    
    init(index:Int)
    {
        super.init(iconImage:kIconImage, index:index)
    }
}