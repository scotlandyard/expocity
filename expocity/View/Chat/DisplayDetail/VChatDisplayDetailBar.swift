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
        self.controller = controller
        
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
    
    override var layer:CALayer
    {
        get
        {
            let colorTop:CGColor = UIColor.redColor().CGColor
            let colorBottom:CGColor = UIColor.blueColor().CGColor
            let gradient:CAGradientLayer = CAGradientLayer()
            gradient.colors = [colorTop, colorBottom]
            gradient.locations = [0, 1]
            
            return gradient
        }
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.parent.pop()
    }
}