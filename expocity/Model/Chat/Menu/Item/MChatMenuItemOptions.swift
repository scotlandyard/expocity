import UIKit

class MChatMenuItemOptions:MChatMenuItem
{
    private let kIcon:String = "chatOptions"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        controller.displayOptions()
    }
}