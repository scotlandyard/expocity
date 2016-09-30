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
        backgroundColor = UIColor.clear
        alpha = 0
        self.controller = controller
        
        let colorTop:CGColor = UIColor(white:0, alpha:0.3).cgColor
        let colorBottom:CGColor = UIColor.clear.cgColor
        let gradientLayer:CAGradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0, 1]
        
        let closeButton:UIButton = UIButton()
        closeButton.clipsToBounds = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(#imageLiteral(resourceName: "genericClose"), for:UIControlState())
        closeButton.imageView!.contentMode = UIViewContentMode.center
        closeButton.imageView!.clipsToBounds = true
        closeButton.addTarget(self, action:#selector(self.actionClose(sender:)), for:UIControlEvents.touchUpInside)
        closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 42)
        
        addSubview(closeButton)
        
        let views:[String:UIView] = [
            "closeButton":closeButton]
        
        let metrics:[String:CGFloat] = [
            "closeButtonWidth":kCloseButtonWidth]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[closeButton(closeButtonWidth)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[closeButton]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override class var layerClass:AnyClass
    {
        return CAGradientLayer.self
    }
    
    //MARK: actions
    
    func actionClose(sender button:UIButton)
    {
        controller.parentController.dismiss()
    }
}
