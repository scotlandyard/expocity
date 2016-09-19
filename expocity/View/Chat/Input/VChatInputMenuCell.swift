import UIKit

class VChatInputMenuCell:UICollectionViewCell
{
    weak var image:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let image:UIImageView = UIImageView()
        image.userInteractionEnabled = false
        image.clipsToBounds = true
        image.contentMode = UIViewContentMode.Center
        image.translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        
        addSubview(image)
        
        let views:[String:AnyObject] = [
            "image":image]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override var selected:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    override var highlighted:Bool
    {
        didSet
        {
            hover()
        }
    }
    
    //MARK: private
    
    private func hover()
    {
        if selected || highlighted
        {
            image.alpha = 0.2
        }
        else
        {
            image.alpha = 1
        }
    }
    
    //MARK: public
    
    func config(model:MChatMenuItem)
    {
        image.image = UIImage(named:model.icon)
        hover()
    }
}