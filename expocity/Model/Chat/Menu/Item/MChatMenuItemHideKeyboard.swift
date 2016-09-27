import UIKit

class MChatMenuItemHideKeyboard:MChatMenuItem
{
    private let kIcon:String = "chatHideKeyboard"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
    }
}
