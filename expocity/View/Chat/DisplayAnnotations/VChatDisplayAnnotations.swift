import UIKit

class VChatDisplayAnnotations:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var shadeTop:UIView!
    weak var shadeBotton:UIView!
    private let kAnimateDuration:NSTimeInterval = 0.3
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        
        
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let topMargin:CGFloat = controller.imageRect.minY
        let leftMargin:CGFloat = controller.imageRect.minX
        let rightMargin:CGFloat = controller.imageRect.maxX - screenRect.maxX
        let bottomMargin:CGFloat = controller.imageRect.maxY - screenRect.maxY
    }
}