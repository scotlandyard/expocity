import Foundation

class MChatMenuStatusStandbyImage:MChatMenuStatus
{
    init()
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemOptions:MChatMenuItemOptions = MChatMenuItemOptions()
        let itemAnnotate:MChatMenuItemAnnotate = MChatMenuItemAnnotate()
        let itemEmoji:MChatMenuItemEmoji = MChatMenuItemEmoji()
        
        let items:[MChatMenuItem] = [
            itemEmoji,
            itemOptions,
            itemAnnotate,
            itemPicture
        ]
        
        super.init(items:items)
    }
}