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
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = controller.model.displayOption.contentMode
        imageView.clipsToBounds = true
        imageView.userInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        addSubview(border)
        addSubview(imageView)
        addSubview(button)
        
        let views:[String:AnyObject] = [
            "border":border,
            "imageView":imageView,
            "button":button]
        
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
            "H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[border(borderHeight)]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(borderHeight)-[button]-(borderHeight)-|",
            options:[],
            metrics:metrics,
            views:views))
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector:#selector(self.notifiedDisplayOptionChanged(sender:)),
            name:NSNotification.NSNotificationName.ChatDisplayOptionChanged.rawValue,
            object:nil)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: notified
    
    func notifiedDisplayOptionChanged(sender notification:NSNotification)
    {
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.updateDisplayOption()
        }
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.displayDetail(imageView)
    }
    
    //MARK: private
    
    private func updateDisplayOption()
    {
        imageView.contentMode = controller.model.displayOption.contentMode
    }
    
    //MARK: public
    
    func displayImage(image:UIImage?)
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