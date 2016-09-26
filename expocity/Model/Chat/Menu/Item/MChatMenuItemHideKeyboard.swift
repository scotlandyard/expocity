import UIKit

class MChatMenuItemHideKeyboard:MChatMenuItem
{
    fileprivate let kIcon:String = "chatHideKeyboard"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(_ controller:CChat)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}
