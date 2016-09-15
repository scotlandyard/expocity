import UIKit

class MChatDisplayOptionsItemFit:MChatDisplayOptionsItem
{
    private let kContentMode:UIViewContentMode = UIViewContentMode.ScaleAspectFit
    private let kIcon:String = ""
    
    init()
    {
        let title:String = NSLocalizedString("", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}