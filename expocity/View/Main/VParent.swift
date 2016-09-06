import UIKit

class VParent:UIView
{
    weak var parent:CParent!
    weak var bar:VBar!
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
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:-delta)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:-delta)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        layoutIfNeeded()
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        parent.controllers.last?.layoutLeft.constant = delta
        parent.controllers.last?.layoutRight.constant = delta
        
        UIView.animateWithDuration(
            kAnimationDurantion,
            animations:
            {
                self.layoutIfNeeded()
            })
        { (done) in
            
            completion()
        }
    }
    
    //MARK: public
    
    func center(controller:CController)
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
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
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
        
        controller.layoutLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:width)
        controller.layoutRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:width)
        
        addConstraint(controller.layoutLeft)
        addConstraint(controller.layoutRight)
        
        layoutIfNeeded()
        
        controller.layoutLeft.constant = 0
        controller.layoutRight.constant = 0
        parent.controllers.last?.layoutLeft.constant = -width_2
        parent.controllers.last?.layoutRight.constant = -width_2
        
        UIView.animateWithDuration(
            kAnimationDurantion,
            animations:
            {
                self.layoutIfNeeded()
            })
        { (done) in
            
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