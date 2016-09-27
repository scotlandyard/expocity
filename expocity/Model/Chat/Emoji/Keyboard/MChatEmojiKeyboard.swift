import Foundation

class MChatEmojiKeyboard
{
    let items:[MChatEmojiKeyboardItem]
    
    init()
    {
        let itemLike:MChatEmojiKeyboardItemLike = MChatEmojiKeyboardItemLike()
        let itemLove:MChatEmojiKeyboardItemLove = MChatEmojiKeyboardItemLove()
        let itemSmile:MChatEmojiKeyboardItemSmile = MChatEmojiKeyboardItemSmile()
        let itemSurprise:MChatEmojiKeyboardItemSurprise = MChatEmojiKeyboardItemSurprise()
        let itemSad:MChatEmojiKeyboardItemSad = MChatEmojiKeyboardItemSad()
        let itemAngry:MChatEmojiKeyboardItemAngry = MChatEmojiKeyboardItemAngry()
        
        items = [
            itemLike,
            itemLove,
            itemSmile,
            itemSurprise,
            itemSad,
            itemAngry
        ]
    }
}
