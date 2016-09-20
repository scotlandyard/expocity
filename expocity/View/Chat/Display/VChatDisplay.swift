import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    weak var imageView:UIImageView!
    weak var layoutHeight:NSLayoutConstraint!
    weak var layoutImageLeft:NSLayoutConstraint!
    weak var layoutBorderHeight:NSLayoutConstraint!
    let maxHeight:CGFloat
    let kMinHeight:CGFloat = 3
    private let kMaxHeightPercent:CGFloat = 0.8
    private let kBorderHeight:CGFloat = 1
    private let kAnimationDuration:NSTimeInterval = 0.3
    
    init(controller:CChat)
    {
        let screenSize:CGSize = UIScreen.mainScreen().bounds.size
        let smallerSize:CGFloat
        
        if screenSize.width > screenSize.height
        {
            smallerSize = screenSize.height
        }
        else
        {
            smallerSize = screenSize.width
        }
        
        maxHeight = smallerSize * kMaxHeightPercent
        
        super.init(frame:CGRectZero)
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
            "V:|-0-[border]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.Left,
            relatedBy:NSLayoutRelation.Equal,
            toItem:self,
            attribute:NSLayoutAttribute.Left,
            multiplier:1,
            constant:0)
        layoutBorderHeight = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutImageLeft)
        addConstraint(layoutBorderHeight)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector:#selector(self.notifiedDisplayOptionChanged(sender:)),
            name:NSNotification.NSNotificationName.ChatDisplayOptionChanged.rawValue,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func layoutSubviews()
    {
        layoutImage()
        super.layoutSubviews()
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
    
    private func layoutImage()
    {
        if imageView.image == nil
        {
            layoutHeight.constant = kMinHeight
            layoutBorderHeight.constant = kBorderHeight
        }
        else
        {
            let screenSize:CGSize = UIScreen.mainScreen().bounds.size
            let screenWidth:CGFloat = screenSize.width
            let screenHeight:CGFloat = screenSize.height
            
            if screenWidth < screenHeight
            {
                layoutHeight.constant = maxHeight
                layoutBorderHeight.constant = kBorderHeight
            }
            else
            {
                layoutBorderHeight.constant = 0
                layoutHeight.constant = 0
            }
        }
        
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
                
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: public
    
    func displayImage(image:UIImage?)
    {
        imageView.image = image
        controller.viewChat.input.updateStandbyMenu()
        layoutImage()
    }
    
    func removeImage()
    {
        imageView.image = nil
        controller.viewChat.input.updateStandbyMenu()
        layoutImage()
    }
}