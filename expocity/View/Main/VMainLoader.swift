import UIKit

class VMainLoader:UIImageView
{
    private let kAnimationDuration:TimeInterval = 1
    
    init()
    {
        super.init(frame:CGRect.zero)
        
        let images:[UIImage] = [
            #imageLiteral(resourceName: "genericLoader0"),
            #imageLiteral(resourceName: "genericLoader1"),
            #imageLiteral(resourceName: "genericLoader2"),
            #imageLiteral(resourceName: "genericLoader3")
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
