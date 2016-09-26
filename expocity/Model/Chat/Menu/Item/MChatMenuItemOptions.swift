import UIKit

class MChatMenuItemOptions:MChatMenuItem
{
    fileprivate let kIcon:String = "chatOptions"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(_ controller:CChat)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        controller.displayOptions()
    }
}
