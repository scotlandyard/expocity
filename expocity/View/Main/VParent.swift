import UIKit

class VParent:UIView
{
    weak var parent:CParent!
    weak var bar:VBar!
    weak var layoutCurrentLeft:NSLayoutConstraint!
    weak var layoutCurrentRight:NSLayoutConstraint!
    
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
    
    //MARK: public
    
    func center(controller:CController)
    {
        addSubview(controller.view)
        
        let views:[String:AnyObject] = [
            "view":controller.view,
            "bar":bar]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[bar]-0-[view]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutCurrentLeft = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        layoutCurrentRight = NSLayoutConstraint(
            item:controller.view,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutCurrentLeft)
        addConstraint(layoutCurrentRight)
    }
}