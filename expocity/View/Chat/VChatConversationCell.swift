import UIKit

class VChatConversationCell:UICollectionViewCell
{
    weak var labelContent:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let labelContent:UILabel = UILabel()
        labelContent.backgroundColor = UIColor.clearColor()
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.userInteractionEnabled = false
        labelContent.numberOfLines = 0
        self.labelContent = labelContent
        
        addSubview(labelContent)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MChatItem, controller:CChat)
    {
        
    }
}