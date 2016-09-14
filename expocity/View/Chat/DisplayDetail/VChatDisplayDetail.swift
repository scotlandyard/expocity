import UIKit

class VChatDisplayDetail:UIView
{
    weak var controller:CChatDisplayDetail!
    weak var layoutImageTop:NSLayoutConstraint!
    weak var layoutImageBottom:NSLayoutConstraint!
    weak var layoutImageLeft:NSLayoutConstraint!
    weak var layoutImageRight:NSLayoutConstraint!
    private let kBarHeight:CGFloat = 50
    
    convenience init(controller:CChatDisplayDetail)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let bar:VChatDisplayDetailBar = VChatDisplayDetailBar(controller:controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.userInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = controller.image
        
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let topMargin:CGFloat = controller.imageRect.minY
        let leftMargin:CGFloat = controller.imageRect.minX
        let rightMargin:CGFloat = controller.imageRect.maxX - screenRect.maxX
        let bottomMargin:CGFloat = controller.imageRect.maxY - screenRect.maxY
        
        addSubview(imageView)
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
            "V:|-0-[bar(barHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageTop = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:topMargin)
        layoutImageBottom = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.Bottom,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Bottom,
            multiplier:1,
            constant:bottomMargin)
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:leftMargin)
        layoutImageRight = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.Right,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Right,
            multiplier:1,
            constant:rightMargin)
        
        addConstraint(layoutImageTop)
        addConstraint(layoutImageBottom)
        addConstraint(layoutImageLeft)
        addConstraint(layoutImageRight)
        
        setNeedsLayout()
    }
}