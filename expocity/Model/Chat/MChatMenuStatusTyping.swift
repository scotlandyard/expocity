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
    
    override func shouldChangeStatus(currentText:String) -> MChatMenuStatus?
    {
        let nextStatus:MChatMenuStatus?
        
        if currentText.isEmpty
        {
            nextStatus = MChatMenuStatusStandby()
        }
        else
        {
            nextStatus = nil
        }
        
        return nextStatus
    }
}