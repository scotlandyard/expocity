import UIKit

class VChatInputMenuCell:UICollectionViewCell
{
    weak var image:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let image:UIImageView = UIImageView()
        image.isUserInteractionEnabled = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.center
        image.translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        
        addSubview(image)
        
        let views:[String:AnyObject] = [
            "image":image]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var isSelected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var isHighlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    fileprivate func hover()
    {
        if isSelected || isHighlighted
        {
            image.alpha = 0.2
        }
        else
        {
            image.alpha = 1
        }
    }
    
    //MARK: public
    
    func config(_ model:MChatMenuItem)
    {
        image.image = UIImage(named:model.icon)
        hover()
    }
}
