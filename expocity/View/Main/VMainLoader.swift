import UIKit

class VMainLoader:UIImageView
{
    private let kAnimationDuration:NSTimeInterval = 2
    
    init()
    {
        super.init(frame:CGRectZero)
        
        let images:[UIImage] = [
            UIImage(named:"genericLoader0")!,
            UIImage(named:"genericLoader1")!,
            UIImage(named:"genericLoader2")!,
            UIImage(named:"genericLoader3")!,
            UIImage(named:"genericLoader4")!
        ]
        
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.Center
        
        startAnimating()
    }
    
    required init?(coder aDecoder:NSCoder)
    {
        fatalError()
    }
}