import UIKit

class VChatDisplayOptions:UIView
{
    weak var controller:CChatDisplayOptions!
    weak var blur:UIView!
    private let kAnimationDuration:NSTimeInterval = 0.3
    
    convenience init(controller:CChatDisplayOptions)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clearColor()
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.Light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.userInteractionEnabled = false
        
        let blur:UIView = UIView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.userInteractionEnabled = false
        blur.alpha = 0
        self.blur = blur
        
        blur.addSubview(visualEffect)
    }
    
    //MARK: public
    
    func animateBlur()
    {
        
    }
}