import UIKit

class VParent:UIView
{
    weak var parent:CParent!
    weak var bar:VBar!
    weak var current:UIView?
    weak var layoutCurrentLeft:NSLayoutConstraint!
    weak var layoutCurrentRight:NSLayoutConstraint!
    weak var layoutBarHeight:NSLayoutConstraint!
    let kBarHeight:CGFloat = 64
    let kBarMinHeight:CGFloat = 20
    private let kAnimationDurantion:NSTimeInterval = 0.3
    
    convenience init(parent:CParent)
    {
        self.init()
        self.parent = parent
        clipsToBounds = true
        backgroundColor = UIColor.whiteColor()
        
        let barDelta:CGFloat = kBarHeight - kBarMinHeight
        let bar:VBar = VBar(parent:parent, barHeight:kBarHeight, barDelta:barDelta)
        self.bar = bar
        addSubview(bar)
        
        let views:[String:AnyObject] = [
            "bar":bar]
        
        let metrics:[String:AnyObject] = [
            "barHeight":kBarHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[bar]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBarHeight = NSLayoutConstraint(
            item:bar,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:kBarHeight)
        
        addConstraint(layoutBarHeight)
    }
    
    //MARK: private
    
    private func scroll(controller:CController, delta:CGFloat, completion:(() -> ()))
    {
        insertSubview(controller.view, belowSubview:bar)
        
        let views:[String:AnyObject] = [
            "view":controller.view]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[view]-0-|",
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
    
    func center(controller:CController)
    {
        current = controller.view
        insertSubview(current!, belowSubview:bar)
        
        let views:[String:AnyObject] = [
            "view":current!]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[view]-0-|",
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
    
    func fromLeft(controller:CController, completion:(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        scroll(controller, delta:width, completion:completion)
    }
    
    func fromRight(controller:CController, completion:(() -> ()))
    {
        let width:CGFloat = -bounds.maxX
        scroll(controller, delta:width, completion:completion)
    }
    
    func push(controller:CController, completion:(() -> ()))
    {
        let width:CGFloat = bounds.maxX
        let width_2:CGFloat = width / 2.0
        
        insertSubview(controller.view, belowSubview:bar)
        
        let views:[String:AnyObject] = [
            "view":controller.view]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[view]-0-|",
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
            constant:width)
        let layoutRight:NSLayoutConstraint = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:width)
        
        addConstraint(layoutLeft)
        addConstraint(layoutRight)
        
        layoutIfNeeded()
        
        layoutLeft.constant = 0
        layoutRight.constant = 0
        layoutCurrentRight.constant = -width_2
        layoutCurrentRight.constant = -width_2
        
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
    
    func scrollDidScroll(scroll:UIScrollView)
    {
        var offsetY:CGFloat = kBarHeight - scroll.contentOffset.y
        
        if offsetY < kBarMinHeight
        {
            offsetY = kBarMinHeight
        }
        
        layoutBarHeight.constant = offsetY
    }
}