import Foundation

class MChatMenu
{
    var items:[MChatMenuItem]
    
    init()
    {
        items = []
        menuStandby()
    }
    
    //MARK: public
    
    func menuTyping()
    {
        let itemSend:MChatMenuItemSend = MChatMenuItemSend()
        
        items = [
            itemSend
        ]
    }
    
    func menuStandby()
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemAnnotate:MChatMenuItemAnnotate = MChatMenuItemAnnotate()
        
        items = [
            itemPicture,
            itemAnnotate
        ]
    }
}