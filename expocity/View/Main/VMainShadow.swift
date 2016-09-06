import UIKit

class VMainShadow:UIView
{
    private let kMaxAlpha:CGFloat = 0.5
    
    init()
    {
        super.init(frame:CGRectZero)
        clipsToBounds = true
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.blackColor()
        
        minAlpha()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func maxAlpha()
    {
        alpha = kMaxAlpha
    }
    
    func minAlpha()
    {
        alpha = 0
    }
}