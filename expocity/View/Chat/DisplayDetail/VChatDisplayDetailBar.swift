import UIKit

class VChatDisplayDetailBar:UIView
{
    weak var controller:CChatDisplayDetail!
    private let kCloseButtonWidth:CGFloat = 80
    
    convenience init(controller:CChatDisplayDetail)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clearColor()
        self.controller = controller
        
        let colorTop:CGColor = UIColor(white:0, alpha:0.6).CGColor
        let colorBottom:CGColor = UIColor.clearColor().CGColor
        let gradientLayer:CAGradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0, 1]
        
        let closeButton:UIButton = UIButton()
        closeButton.clipsToBounds = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action:#selector(self.actionClose(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(closeButton)
        
        let views:[String:AnyObject] = [
            "closeButton":closeButton]
        
        let metrics:[String:AnyObject] = [
            "closeButtonWidth":kCloseButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[closeButton(closeButtonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[closeButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override class func layerClass() -> AnyClass
    {
        return CAGradientLayer.self
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.parent.pop()
    }
}