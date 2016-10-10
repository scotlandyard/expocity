import Foundation

class MChatMenuStatusTypeReady:MChatMenuStatus
{
    init()
    {
        let itemEmoji:MChatMenuItemEmoji = MChatMenuItemEmoji()
        let itemHideKeyboard:MChatMenuItemHideKeyboard = MChatMenuItemHideKeyboard()
        
        let items:[MChatMenuItem] = [
            itemEmoji,
            itemHideKeyboard
        ]
        
        super.init(items:items)
    }
}