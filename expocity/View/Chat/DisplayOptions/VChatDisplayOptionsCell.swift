import UIKit

class VChatDisplayOptionsCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var image:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.regular(12)
        label.textAlignment = NSTextAlignment.Center
        self.label = label
        
        addSubview(label)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MChatDisplayOptionsItem)
    {
        
    }
}