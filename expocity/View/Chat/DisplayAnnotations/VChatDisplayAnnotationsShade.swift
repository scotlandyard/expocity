import UIKit

class VChatDisplayAnnotationsShade:UIView
{
    init(borderTop:Bool, borderBottom:Bool)
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
        
        let borderColor:UIColor = UIColor.blackColor()
        
        let topBorder:UIView = UIView()
        topBorder.userInteractionEnabled = false
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.backgroundColor = borderColor
        
        let bottomBorder:UIView = UIView()
        bottomBorder.userInteractionEnabled = false
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = borderColor
        
        addSubview(blurView)
        addSubview(topBorder)
        addSubview(bottomBorder)
        
        let views:[String:AnyObject] = [
            "blurView":blurView,
            "topBorder":topBorder,
            "bottomBorder":bottomBorder]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[topBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[bottomBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[topBorder(1)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[bottomBorder(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        if !borderTop
        {
            topBorder.hidden = true
        }
        
        if !borderBottom
        {
            bottomBorder.hidden = true
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}