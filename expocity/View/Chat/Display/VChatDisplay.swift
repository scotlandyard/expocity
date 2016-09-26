import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    weak var marks:VChatDisplayMarks!
    weak var imageView:UIImageView!
    weak var layoutHeight:NSLayoutConstraint!
    weak var layoutImageLeft:NSLayoutConstraint!
    weak var layoutBorderHeight:NSLayoutConstraint!
    let maxHeight:CGFloat
    let kMinHeight:CGFloat = 3
    fileprivate let kMaxHeightPercent:CGFloat = 0.8
    fileprivate let kBorderHeight:CGFloat = 1
    fileprivate let kAnimationDuration:TimeInterval = 0.3
    
    init(controller:CChat)
    {
        let screenSize:CGSize = UIScreen.main.bounds.size
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
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        
        self.controller = controller
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.bubbleMine()
        
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = controller.model.displayOption.contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView = imageView
        
        let marks:VChatDisplayMarks = VChatDisplayMarks(controller:controller)
        self.marks = marks
        
        addSubview(border)
        addSubview(imageView)
        addSubview(marks)
        
        let views:[String:AnyObject] = [
            "border":border,
            "imageView":imageView,
            "marks":marks]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[marks]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[border]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[border]-0-[marks]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        layoutBorderHeight = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutImageLeft)
        addConstraint(layoutBorderHeight)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedDisplayOptionChanged(sender:)),
            name:Notification.Name.ChatDisplayOptionChanged.rawValue,
            object:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    deinit
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews()
    {
        layoutImage()
        super.layoutSubviews()
    }
    
    //MARK: notified
    
    func notifiedDisplayOptionChanged(sender notification:Notification)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.updateDisplayOption()
        }
    }
    
    //MARK: private
    
    fileprivate func updateDisplayOption()
    {
        imageView.contentMode = controller.model.displayOption.contentMode
    }
    
    fileprivate func layoutImage()
    {
        if imageView.image == nil
        {
            layoutHeight.constant = kMinHeight
            layoutBorderHeight.constant = kBorderHeight
        }
        else
        {
            let screenSize:CGSize = UIScreen.main.bounds.size
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
        
        UIView.animate(withDuration: kAnimationDuration, animations: { [weak self] in
                
            self?.layoutIfNeeded()
        })
        
    }
    
    //MARK: public
    
    func displayImage(_ image:UIImage?)
    {
        imageView.image = image
        controller.viewChat.input.updateStandbyMenu()
        layoutImage()
        marks.addItems()
    }
    
    func removeImage()
    {
        imageView.image = nil
        controller.viewChat.input.updateStandbyMenu()
        layoutImage()
    }
    
    func displayAnnotations()
    {
        marks.isHidden = true
    }
    
    func hideAnnotations()
    {
        marks.isHidden = false
    }
}
