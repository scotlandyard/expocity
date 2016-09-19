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
        let topMargin:CGFloat = controller.imageRect.minY
        let leftMargin:CGFloat = controller.imageRect.minX
        let rightMargin:CGFloat = controller.imageRect.maxX - screenRect.maxX
        let bottomMargin:CGFloat = controller.imageRect.maxY - screenRect.maxY
    }
}