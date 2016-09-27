import UIKit

class MChatDisplayOptionsItemFit:MChatDisplayOptionsItem
{
    private let kContentMode:UIViewContentMode = UIViewContentMode.scaleAspectFit
    private let kIcon:String = "chatDisplayFit"
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemFit_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}
