import UIKit

class MMenuItemHome:MMenuItem
{
    private let kIconImage:String = "menuHome"
    
    init(index:Int)
    {
        let title:String = NSLocalizedString("MMenuItemHome_title", comment:"")
        
        super.init(title:title, iconImage:kIconImage, index:index)
    }
    
    override func controller() -> CController
    {
        let controller:CHome = CHome()
        
        return controller
    }
}