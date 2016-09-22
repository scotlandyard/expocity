import Foundation

class MChatMenuStatusStandby:MChatMenuStatus
{
    init()
    {
        let itemPicture:MChatMenuItemPicture = MChatMenuItemPicture()
        let itemEmoji:MChatMenuItemEmoji = MChatMenuItemEmoji()
        
        let items:[MChatMenuItem] = [
            itemEmoji,
            itemPicture
        ]
        
        super.init(items:items)
    }
}