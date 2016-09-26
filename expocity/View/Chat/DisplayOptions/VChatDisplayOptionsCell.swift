import UIKit

class VChatDisplayOptionsCell:UICollectionViewCell
{
    weak var label:UILabel!
    weak var imageView:UIImageView!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(14)
        label.textAlignment = NSTextAlignment.center
        self.label = label
        
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.center
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(label)
        addSubview(imageView)
        
        let views:[String:AnyObject] = [
            "imageView":imageView,
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-59-[label]-0-|",
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
            label.textColor = UIColor.main()
            imageView.tintColor = UIColor.main()
        }
        else
        {
            label.textColor = UIColor(white:0.8, alpha:1)
            imageView.tintColor = UIColor(white:0.7, alpha:1)
        }
    }
    
    //MARK: public
    
    func config(_ model:MChatDisplayOptionsItem)
    {
        label.text = model.title
        imageView.image = UIImage(named:model.icon)!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        hover()
    }
}
