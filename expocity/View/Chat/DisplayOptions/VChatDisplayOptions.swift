import UIKit

class VChatDisplayOptions:UIView
{
    weak var controller:CChatDisplayOptions!
    weak var blur:UIView!
    private let kAnimationDuration:NSTimeInterval = 0.3
    private let kCornerRadius:CGFloat = 4
    private let kBaseMarginVertical:CGFloat = 40
    private let kBaseMarginHorizontal:CGFloat = 10
    
    convenience init(controller:CChatDisplayOptions)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clearColor()
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.Light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.userInteractionEnabled = false
        
        let blur:UIView = UIView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.userInteractionEnabled = false
        blur.alpha = 0
        self.blur = blur
        
        let base:UIView = UIView()
        base.backgroundColor = UIColor.whiteColor()
        base.translatesAutoresizingMaskIntoConstraints = false
        base.clipsToBounds = true
        base.layer.borderWidth = 1
        base.layer.borderColor = UIColor(white:0, alpha:0.1).CGColor
        base.layer.cornerRadius = kCornerRadius
        
        blur.addSubview(visualEffect)
        addSubview(blur)
        addSubview(base)
        
        let views:[String:AnyObject] = [
            "visualEffect":visualEffect,
            "blur":blur,
            "base":base]
        
        let metrics:[String:AnyObject] = [
            "baseMarginVertical":kBaseMarginVertical,
            "baseMarginHorizontal":kBaseMarginHorizontal]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(baseMarginHorizontal)-[base]-(baseMarginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(baseMarginVertical)-[base]-(baseMarginVertical)-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: public
    
    func animateBlur()
    {
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.blur.alpha = 1
        }
    }
}