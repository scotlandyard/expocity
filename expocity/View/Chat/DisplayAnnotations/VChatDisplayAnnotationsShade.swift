import UIKit

class VChatDisplayAnnotationsShade:UIView
{
    init(borderTop:Bool, borderBottom:Bool)
    {
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        alpha = 0
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.dark)
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.clipsToBounds = true
        
        let borderColor:UIColor = UIColor.black
        
        let topBorder:UIView = UIView()
        topBorder.isUserInteractionEnabled = false
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.backgroundColor = borderColor
        
        let bottomBorder:UIView = UIView()
        bottomBorder.isUserInteractionEnabled = false
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = borderColor
        
        addSubview(blurView)
        addSubview(topBorder)
        addSubview(bottomBorder)
        
        let views:[String:AnyObject] = [
            "blurView":blurView,
            "topBorder":topBorder,
            "bottomBorder":bottomBorder]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[topBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bottomBorder]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blurView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[topBorder(1)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[bottomBorder(1)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        if !borderTop
        {
            topBorder.isHidden = true
        }
        
        if !borderBottom
        {
            bottomBorder.isHidden = true
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
