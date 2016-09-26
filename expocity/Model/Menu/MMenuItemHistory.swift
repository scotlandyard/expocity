import UIKit

class MMenuItemHistory:MMenuItem
{
    fileprivate let kIconImage:String = "menuHistory"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemHistory_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
    
    override func controller() -> CController
    {
        let controller:CHome = CHome()
        
        return controller
    }
}
