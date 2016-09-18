import UIKit

class MChatDisplayOptionsItemFit:MChatDisplayOptionsItem
{
    private let kContentMode:UIViewContentMode = UIViewContentMode.ScaleAspectFit
    private let kIcon:String = ""
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemFit_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}