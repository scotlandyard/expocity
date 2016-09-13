import Foundation

class MChatMenuStatusStandby:MChatMenuStatus
{
    init()
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemAnnotate:MChatMenuItemAnnotate = MChatMenuItemAnnotate()
        
        let items:[MChatMenuItem] = [
            itemPicture,
            itemAnnotate
        ]
        
        super.init(items:items)
    }
    
    override func shouldChangeStatus(currentText:String) -> MChatMenuStatus?
    {
        let nextStatus:MChatMenuStatus?
        
        if currentText.isEmpty
        {
            nextStatus = nil
        }
        else
        {
            nextStatus = MChatMenuStatusTyping()
        }
        
        return nextStatus
    }
}