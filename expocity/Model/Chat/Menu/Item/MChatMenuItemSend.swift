import UIKit

class MChatMenuItemSend:MChatMenuItem
{
    private let kIcon:String = "chatSend"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
        controller.viewChat.input.actionSend()
    }
}
