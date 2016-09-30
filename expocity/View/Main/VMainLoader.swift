import UIKit

class VMainLoader:UIImageView
{
    private let kAnimationDuration:TimeInterval = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            UIImage(named:"genericLoader0")!,
            UIImage(named:"genericLoader1")!,
            UIImage(named:"genericLoader2")!,
            UIImage(named:"genericLoader3")!
        ]
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        animationDuration = kAnimationDuration
        animationImages = images
        contentMode = UIViewContentMode.center
        
        startAnimating()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
}
