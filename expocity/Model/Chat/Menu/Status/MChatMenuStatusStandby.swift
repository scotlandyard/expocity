import Foundation

class MChatMenuStatusStandby:MChatMenuStatus
{
    init()
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemOptions:MChatMenuItemOptions = MChatMenuItemOptions()
        let itemAnnotate:MChatMenuItemAnnotate = MChatMenuItemAnnotate()
        
        let items:[MChatMenuItem] = [
            itemPicture,
            itemOptions,
            itemAnnotate
        ]
        
        super.init(items:items)
    }
}