import UIKit

class VChatConversationCell:UICollectionViewCell
{
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
    
    //MARK: public
    
    func config(model:MChatItem, controller:CChat)
    {
        model.cell = self
    }
    
    func layoutConstraints()
    {
    }
}