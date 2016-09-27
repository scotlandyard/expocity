import Foundation

class MChatEmojiKeyboard
{
    let items:[MChatEmojiKeyboardItem]
    
    init()
    {
        let itemLike:MChatEmojiKeyboardItemLike = MChatEmojiKeyboardItemLike()
        let itemLove:MChatEmojiKeyboardItemLove = MChatEmojiKeyboardItemLove()
        let itemSmile:MChatEmojiKeyboardItemSmile = MChatEmojiKeyboardItemSmile()
        let itemSad:MChatEmojiKeyboardItemSad = MChatEmojiKeyboardItemSad()
        let itemAngry:MChatEmojiKeyboardItemAngry = MChatEmojiKeyboardItemAngry()
        
        items = [
            itemLike,
            itemLove,
            itemSmile,
            itemSad,
            itemAngry
        ]
    }
}
