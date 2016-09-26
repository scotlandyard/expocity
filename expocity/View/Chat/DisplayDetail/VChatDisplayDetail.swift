import UIKit

class VChatDisplayDetail:UIView
{
    weak var controller:CChatDisplayDetail!
    weak var bar:VChatDisplayDetailBar!
    weak var blur:UIView!
    weak var layoutImageTop:NSLayoutConstraint!
    weak var layoutImageBottom:NSLayoutConstraint!
    weak var layoutImageLeft:NSLayoutConstraint!
    weak var layoutImageRight:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 64
    private let kAnimateDuration:TimeInterval = 0.3
    
    convenience init(controller:CChatDisplayDetail)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let bar:VChatDisplayDetailBar = VChatDisplayDetailBar(controller:controller)
        self.bar = bar
        
        let blurEffect:UIVisualEffect = UIBlurEffect(style:UIBlurEffectStyle.dark)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.isUserInteractionEnabled = false
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        
        let blur:UIView = UIView()
        blur.isUserInteractionEnabled = false
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.backgroundColor = UIColor.clear
        blur.alpha = 0
        self.blur = blur
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = controller.displayOption.contentMode
        imageView.clipsToBounds = true
        imageView.image = controller.image
        
        let screenRect:CGRect = UIScreen.main.bounds
        let topMargin:CGFloat = controller.imageRect.minY
        let leftMargin:CGFloat = controller.imageRect.minX
        let rightMargin:CGFloat = controller.imageRect.maxX - screenRect.maxX
        let bottomMargin:CGFloat = controller.imageRect.maxY - screenRect.maxY
        
        blur.addSubview(visualEffect)
        addSubview(blur)
        addSubview(imageView)
        addSubview(bar)
        
        let views:[String:AnyObject] = [
            "bar":bar,
            "blur":blur,
            "visualEffect":visualEffect]
        
        let metrics:[String:CGFloat] = [
            "barHeight":kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageTop = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:topMargin)
        layoutImageBottom = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.bottom,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.bottom,
            multiplier:1,
            constant:bottomMargin)
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:leftMargin)
        layoutImageRight = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.right,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.right,
            multiplier:1,
            constant:rightMargin)
        
        addConstraint(layoutImageTop)
        addConstraint(layoutImageBottom)
        addConstraint(layoutImageLeft)
        addConstraint(layoutImageRight)
    }
    
    //MARK: public
    
    func animateImage()
    {
        let animationDuration:TimeInterval = kAnimateDuration
        layoutImageTop.constant = 0
        layoutImageBottom.constant = 0
        layoutImageLeft.constant = 0
        layoutImageRight.constant = 0
        
        UIView.animate(withDuration: animationDuration, animations:
        { [weak self] in
            
            self?.layoutIfNeeded()
            self?.blur.alpha = 1
        }, completion: { (done) in
            
            UIView.animate(withDuration: animationDuration, animations: { [weak self] in
                
                self?.bar.alpha = 1
            })
            
        })
        
    }
}
