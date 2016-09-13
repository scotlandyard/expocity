import Foundation

class MChatMenuStatusTyping:MChatMenuStatus
{
    override func items() -> [MChatMenuItem]
    {
        let itemSend:MChatMenuItemSend = MChatMenuItemSend()
        
        let items:[MChatMenuItem] = [
            itemSend
        ]
        
        return items
    }
}