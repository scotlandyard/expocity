import UIKit

class VChatEmojiKeyboardFooter:UICollectionReusableView
{
    weak var controller:CChat!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
