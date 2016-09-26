import UIKit

class MChatDisplayOptionsItemFit:MChatDisplayOptionsItem
{
    fileprivate let kContentMode:UIViewContentMode = UIViewContentMode.scaleAspectFit
    fileprivate let kIcon:String = "chatDisplayFit"
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemFit_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}
