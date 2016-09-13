import Foundation

class MChatMenuStatusTyping:MChatMenuStatus
{
    init()
    {
        let itemSend:MChatMenuItemSend = MChatMenuItemSend()
        
        let items:[MChatMenuItem] = [
            itemSend
        ]
        
        super.init(items:items)
    }
}