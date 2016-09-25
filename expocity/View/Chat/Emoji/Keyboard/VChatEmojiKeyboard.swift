import UIKit

class VChatEmojiKeyboard:UIView
{
    weak var controller:CChat!
    
    init(controller:CChat)
    {
        super.init(frame:CGRectZero)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}