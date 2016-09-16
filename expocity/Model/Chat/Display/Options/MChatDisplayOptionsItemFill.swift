import UIKit

class MChatDisplayOptionsItemFill:MChatDisplayOptionsItem
{
    private let kContentMode:UIViewContentMode = UIViewContentMode.ScaleAspectFill
    private let kIcon:String = ""
    
    init()
    {
        let title:String = NSLocalizedString("", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}