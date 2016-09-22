import UIKit

class VChatDisplayAnnotationsListCell:UICollectionViewCell
{
    weak var label:UILabel!
    private let kButtonRemoveWidth:CGFloat = 55
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor(white:1, alpha:0.1)
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(13)
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
        
        let views:[String:AnyObject] = [
            "label":label,
            "buttonRemove":buttonRemove]
        
        let metrics:[String:AnyObject] = [
            "buttonRemoveWidth":kButtonRemoveWidth]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[label]-0-[buttonRemove(buttonRemoveWidth)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[buttonRemove]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MChatDisplayAnnotationsItem)
    {
        label.text = model.text
    }
}