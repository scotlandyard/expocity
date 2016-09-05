import UIKit

class VBarCell:UICollectionViewCell
{
    weak var icon:UIImageView!
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
        
        addSubview(icon)
        
        let views:[String:AnyObject] = [
            "icon":icon]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-20-[icon]-0-|",
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
        }
        else
        {
            icon.image = UIImage(named:model.iconImageOff)
        }
    }
    
    //MARK: public
    
    func config(model:MMenuItem)
    {
        self.model = model
        hover()
    }
}