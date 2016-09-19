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
        
        let shadeColor:UIColor = UIColor(white:0, alpha:0.6)
        
        let shadeTop:UIView = UIView()
        shadeTop.userInteractionEnabled = false
        shadeTop.translatesAutoresizingMaskIntoConstraints = false
        shadeTop.clipsToBounds = true
        shadeTop.backgroundColor = shadeColor
        shadeTop.alpha = 0
        self.shadeTop = shadeTop
        
        let shadeBottom:UIView = UIView()
        shadeBottom.userInteractionEnabled = false
        shadeBottom.translatesAutoresizingMaskIntoConstraints = false
        shadeBottom.clipsToBounds = true
        shadeBottom.backgroundColor = shadeColor
        shadeBottom.alpha = 0
        self.shadeBottom = shadeBottom
        
        addSubview(shadeTop)
        addSubview(shadeBottom)
        
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let topHeight:CGFloat = controller.imageRect.minY
        let bottomHeight:CGFloat = screenRect.maxY - controller.imageRect.maxY
        
        let views:[String:AnyObject] = [
            "shadeTop":shadeTop,
            "shadeBottom":shadeBottom]
        
        let metrics:[String:AnyObject] = [
            "topHeight":topHeight,
            "bottomHeight":bottomHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shateTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shateBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[shateTop(topHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[shateBottom(bottomHeight)]-0-|",
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