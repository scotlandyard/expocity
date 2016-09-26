import UIKit

class MChatMenuItemSend:MChatMenuItem
{
    fileprivate let kIcon:String = "chatSend"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(_ controller:CChat)
    {
        controller.viewChat.input.actionSend()
    }
}
