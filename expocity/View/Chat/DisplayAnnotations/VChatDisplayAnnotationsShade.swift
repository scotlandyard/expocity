import UIKit

class VChatDisplayAnnotationsShade:UIView
{
    init()
    {
        super.init(frame:CGRectZero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        alpha = 0
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.Dark)
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blurView.userInteractionEnabled = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.clipsToBounds = true
        
        addSubview(blurView)
        
        let views:[String:AnyObject] = [
            "blurView":blurView]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}