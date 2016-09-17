import UIKit

class VChatDisplayOptionsCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var imageView:UIImageView!
    
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
        
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.Center
        imageView.clipsToBounds = true
        imageView.userInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        let views:[String:AnyObject] = [
            "imageView":imageView,
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[imageView(30)]-0-[label(15)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MChatDisplayOptionsItem)
    {
        label.text = model.title
        imageView.image = UIImage(named:model.icon)
    }
}