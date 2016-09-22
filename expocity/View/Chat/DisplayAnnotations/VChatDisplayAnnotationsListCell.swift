import UIKit

class VChatDisplayAnnotationsListCell:UICollectionViewCell
{
    weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(14)
        label.textColor = UIColor(white:1, alpha:0.7)
        label.backgroundColor = UIColor.clearColor()
        self.label = label
        
        let buttonRemove:UIButton = UIButton()
        buttonRemove.setImage(UIImage(named:"chatAnnotationRemove"), forState:UIControlState.Normal)
        buttonRemove.imageView!.contentMode = UIViewContentMode.Center
        buttonRemove.imageView!.clipsToBounds = true
        buttonRemove.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(buttonRemove)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MChatDisplayAnnotationsItem)
    {
        
    }
}