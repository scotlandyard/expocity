import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    weak var image:UIImageView!
    weak var layoutHeight:NSLayoutConstraint!
    let kMinHeight:CGFloat = 5
    private let kBorderHeight:CGFloat = 1
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        
        self.controller = controller
        
        let border:UIView = UIView()
        border.userInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.bubbleMine()
        
        let image:UIImageView = UIImageView()
        image.contentMode = UIViewContentMode.ScaleAspectFill
        image.clipsToBounds = true
        image.userInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        
        addSubview(border)
        addSubview(image)
        
        let views:[String:AnyObject] = [
            "border":border,
            "image":image]
        
        let metrics:[String:AnyObject] = [
            "borderHeight":kBorderHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[border(borderHeight)]-0-[image]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}