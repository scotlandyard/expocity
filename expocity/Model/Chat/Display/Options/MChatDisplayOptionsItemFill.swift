import UIKit

class MChatDisplayOptionsItemFill:MChatDisplayOptionsItem
{
    fileprivate let kContentMode:UIViewContentMode = UIViewContentMode.scaleAspectFill
    fileprivate let kIcon:String = "chatDisplayFill"
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemFill_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}
