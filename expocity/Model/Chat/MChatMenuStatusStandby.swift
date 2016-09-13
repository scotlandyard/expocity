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
}