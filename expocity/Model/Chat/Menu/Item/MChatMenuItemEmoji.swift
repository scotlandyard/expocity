import UIKit

class MChatMenuItemEmoji:MChatMenuItem
{
    private let kIcon:String = "chatEmoji"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(controller:CChat)
    {
    }
}
