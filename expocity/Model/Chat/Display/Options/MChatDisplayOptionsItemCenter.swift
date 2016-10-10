import UIKit

class MChatDisplayOptionsItemCenter:MChatDisplayOptionsItem
{
    private let kContentMode:UIViewContentMode = UIViewContentMode.center
    private let kIcon:String = "chatDisplayCenter"
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemCenter_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}
