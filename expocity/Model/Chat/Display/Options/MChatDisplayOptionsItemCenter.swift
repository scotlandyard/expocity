import UIKit

class MChatDisplayOptionsItemCenter:MChatDisplayOptionsItem
{
    private let kContentMode:UIViewContentMode = UIViewContentMode.Center
    private let kIcon:String = ""
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemCenter_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}