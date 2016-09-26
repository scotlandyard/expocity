import UIKit

class MChatMenuItemEmoji:MChatMenuItem
{
    fileprivate let kIcon:String = "chatEmoji"
    
    init()
    {
        super.init(icon:kIcon)
    }
    
    override func selected(_ controller:CChat)
    {
    }
}
