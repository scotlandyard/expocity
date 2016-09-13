import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    weak var imageView:UIImageView!
    weak var layoutHeight:NSLayoutConstraint!
    let kMinHeight:CGFloat = 5
    private let kBorderHeight:CGFloat = 1
    private let kMaxHeight:CGFloat = 200
    private let kAnimationDuration:NSTimeInterval = 0.3
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        
        self.controller = controller
        
        let border:UIView = UIView()
        border.userInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.bubbleMine()
        
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.userInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(border)
        addSubview(imageView)
        
        let views:[String:AnyObject] = [
            "border":border,
            "imageView":imageView]
        
        let metrics:[String:AnyObject] = [
            "borderHeight":kBorderHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[border(borderHeight)]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: public
    
    func displayImage(image:UIImage)
    {
        imageView.image = image
        layoutHeight.constant = kMaxHeight
        
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    func removeImage()
    {
        layoutHeight.constant = kMinHeight
        
        UIView.animateWithDuration(kAnimationDuration, animations:
            { [weak self] in
                
                self?.layoutIfNeeded()
                
            })
        { [weak self] (done) in
            
            self?.imageView.image = nil
        }
    }
}