import UIKit

class VBarCell:UICollectionViewCell
{
    weak var icon:UIImageView!
    private let kIconHeight:CGFloat = 44
    
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
        
        addSubview(icon)
        
        let views:[String:AnyObject] = [
            "icon":icon]
        
        let metrics:[String:AnyObject] = [
            "iconHeight":kIconHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[icon]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config()
    {
        
    }
}