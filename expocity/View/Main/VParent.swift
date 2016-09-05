import UIKit

class VParent:UIView
{
    weak var parent:CParent!
    weak var bar:VBar!
    weak var current:UIView?
    weak var layoutCurrentLeft:NSLayoutConstraint!
    weak var layoutCurrentRight:NSLayoutConstraint!
    private let kAnimationDurantion:NSTimeInterval = 0.3
    
    convenience init(parent:CParent)
    {
        self.init()
        self.parent = parent
        clipsToBounds = true
        backgroundColor = UIColor.whiteColor()
        
        let bar:VBar = VBar(parent:parent)
        self.bar = bar
        addSubview(bar)
        
        let views:[String:AnyObject] = [
            "bar":bar]
        
        let metrics:[String:AnyObject] = [
            "barHeight":parent.kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func scroll(controller:UIViewController, delta:CGFloat, completion:(() -> ()))
    {
        addSubview(controller.view)
        
        let views:[String:AnyObject] = [
            "view":controller.view,
            "bar":bar]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[bar]-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        let layoutLeft:NSLayoutConstraint = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:-delta)
        let layoutRight:NSLayoutConstraint = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:-delta)
        
        addConstraint(layoutLeft)
        addConstraint(layoutRight)
        
        layoutIfNeeded()
        
        layoutLeft.constant = 0
        layoutRight.constant = 0
        layoutCurrentRight.constant = delta
        layoutCurrentRight.constant = delta
        
        UIView.animateWithDuration(
            kAnimationDurantion,
            animations:
            {
                self.layoutIfNeeded()
            })
        { (done) in
            
            self.current?.removeFromSuperview()
            self.current = controller.view
            self.layoutCurrentRight = layoutRight
            self.layoutCurrentLeft = layoutLeft
            
            completion()
        }
    }
    
    //MARK: public
    
    func center(controller:UIViewController)
    {
        current = controller.view
        addSubview(current!)
        
        let views:[String:AnyObject] = [
            "view":current!,
            "bar":bar]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[bar]-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCurrentLeft = NSLayoutConstraint(
            item:current!,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        layoutCurrentRight = NSLayoutConstraint(
            item:current!,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCurrentLeft)
        addConstraint(layoutCurrentRight)
    }
    
    func fromLeft(controller:UIViewController, completion:(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        scroll(controller, delta:width, completion:completion)
    }
    
    func fromRight(controller:UIViewController, completion:(() -> ()))
    {
        let width:CGFloat = -bounds.maxX
        scroll(controller, delta:width, completion:completion)
    }
}