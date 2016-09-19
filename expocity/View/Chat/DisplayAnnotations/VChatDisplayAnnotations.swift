import UIKit

class VChatDisplayAnnotations:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var shadeTop:UIView!
    weak var shadeBottom:UIView!
    private let kAnimateDuration:NSTimeInterval = 0.3
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.Dark)
        
        let blurTop:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blurTop.userInteractionEnabled = false
        blurTop.translatesAutoresizingMaskIntoConstraints = false
        
        let blurBottom:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        blurBottom.userInteractionEnabled = false
        blurBottom.translatesAutoresizingMaskIntoConstraints = false
        
        let shadeTop:UIView = UIView()
        shadeTop.userInteractionEnabled = false
        shadeTop.translatesAutoresizingMaskIntoConstraints = false
        shadeTop.clipsToBounds = true
        shadeTop.alpha = 0
        self.shadeTop = shadeTop
        
        let shadeBottom:UIView = UIView()
        shadeBottom.userInteractionEnabled = false
        shadeBottom.translatesAutoresizingMaskIntoConstraints = false
        shadeBottom.clipsToBounds = true
        shadeBottom.alpha = 0
        self.shadeBottom = shadeBottom
        
        shadeTop.addSubview(blurTop)
        shadeBottom.addSubview(blurBottom)
        addSubview(shadeTop)
        addSubview(shadeBottom)
        
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let topHeight:CGFloat = controller.imageRect.minY
        let bottomHeight:CGFloat = screenRect.maxY - controller.imageRect.maxY
        
        let views:[String:AnyObject] = [
            "shadeTop":shadeTop,
            "shadeBottom":shadeBottom,
            "blurTop":blurTop,
            "blurBottom":blurBottom]
        
        let metrics:[String:AnyObject] = [
            "topHeight":topHeight,
            "bottomHeight":bottomHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blurTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blurBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadeTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blurTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blurBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[shadeTop(topHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[shadeBottom(bottomHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: public
    
    func animateShades()
    {
        UIView.animateWithDuration(
            kAnimateDuration, animations:
        { [weak self] in
            
            self?.shadeTop.alpha = 1
            self?.shadeBottom.alpha = 1
        })
        { [weak self] (done) in
            
            
        }
    }
}