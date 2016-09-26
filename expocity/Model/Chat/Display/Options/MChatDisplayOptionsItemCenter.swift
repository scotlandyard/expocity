import UIKit

class MChatDisplayOptionsItemCenter:MChatDisplayOptionsItem
{
    fileprivate let kContentMode:UIViewContentMode = UIViewContentMode.center
    fileprivate let kIcon:String = "chatDisplayCenter"
    
    init()
    {
        let title:String = NSLocalizedString("MChatDisplayOptionsItemCenter_title", comment:"")
        
        super.init(title:title, icon:kIcon, contentMode:kContentMode)
    }
}
