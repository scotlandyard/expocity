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
        backgroundColor = UIColor(white:1, alpha:0.8)
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let bar:VChatDisplayDetailBar = VChatDisplayDetailBar(controller:controller)
        
        let imageView:UIImageView = UIImageView()
        imageView.userInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        
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
    }
}