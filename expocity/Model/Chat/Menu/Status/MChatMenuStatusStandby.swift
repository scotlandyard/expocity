import Foundation

class MChatMenuStatusStandby:MChatMenuStatus
{
    init()
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemRemovePicture:MChatMenuItemRemovePicture = MChatMenuItemRemovePicture()
        let itemOptions:MChatMenuItemOptions = MChatMenuItemOptions()
        let itemAnnotate:MChatMenuItemAnnotate = MChatMenuItemAnnotate()
        
        let items:[MChatMenuItem] = [
            itemPicture,
            itemRemovePicture,
            itemOptions,
            itemAnnotate
        ]
        
        super.init(items:items)
    }
}