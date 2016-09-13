import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    weak var layoutHeight:NSLayoutConstraint!
    let kMinHeight:CGFloat = 100
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
        
        addSubview(border)
        
        let views:[String:AnyObject] = [
            "border":border]
        
        let metrics:[String:AnyObject] = [
            "borderHeight":kBorderHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[border(borderHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}