import UIKit

class VBarCell:UICollectionViewCell
{
    weak var icon:UIImageView!
    weak var label:UILabel!
    weak var model:MMenuItem!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        
        let icon:UIImageView = UIImageView()
        icon.userInteractionEnabled = false
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = UIViewContentMode.Center
        self.icon = icon
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.regular(11)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.label = label
        
        addSubview(icon)
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "icon":icon,
            "label":label]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-32-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[label(20)]",
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
            icon.image = UIImage(named:model.iconImageOn)
            label.textColor = UIColor.whiteColor()
        }
        else
        {
            icon.image = UIImage(named:model.iconImageOff)
            label.textColor = UIColor(white:1, alpha:0.5)
        }
    }
    
    //MARK: public
    
    func config(model:MMenuItem)
    {
        self.model = model
        label.text = model.title
        hover()
    }
}