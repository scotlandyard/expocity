import UIKit

class VChatDisplay:UIView
{
    weak var controller:CChat!
    weak var marks:VChatDisplayMarks!
    weak var imageView:UIImageView!
    weak var layoutHeight:NSLayoutConstraint!
    weak var layoutBorderHeight:NSLayoutConstraint!
    let maxHeight:CGFloat
    let kMinHeight:CGFloat = 3
    private let kMaxHeightPercent:CGFloat = 0.8
    private let kBorderHeight:CGFloat = 1
    private let kAnimationDuration:TimeInterval = 0.3
    
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
        
        let views:[String:UIView] = [
            "border":border,
            "imageView":imageView,
            "marks":marks]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[marks]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[border]-0-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border]-0-[marks]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutBorderHeight = NSLayoutConstraint(
            item:border,
            attribute:NSLayoutAttribute.height,
            relatedBy:NSLayoutRelation.equal,
            toItem:nil,
            attribute:NSLayoutAttribute.notAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutBorderHeight)
        
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(self.notifiedDisplayOptionChanged(sender:)),
            name:Notification.Notifications.ChatDisplayOptionChanged.Value,
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
    
    private func updateDisplayOption()
    {
        imageView.contentMode = controller.model.displayOption.contentMode
    }
    
    private func layoutImage()
    {
        var animate:Bool = false
        let newHeight:CGFloat
        let newBorderHeight:CGFloat
        
        if imageView.image == nil
        {
            newHeight = kMinHeight
            newBorderHeight = kBorderHeight
        }
        else
        {
            let screenSize:CGSize = UIScreen.main.bounds.size
            let screenWidth:CGFloat = screenSize.width
            let screenHeight:CGFloat = screenSize.height
            
            if screenWidth < screenHeight
            {
                newHeight = maxHeight
                newBorderHeight = kBorderHeight
            }
            else
            {
                newHeight = 0
                newBorderHeight = 0
            }
        }
        
        if newHeight != layoutHeight.constant
        {
            animate = true
        }
        
        if animate
        {
            if newBorderHeight == 0
            {
                layoutBorderHeight.constant = newBorderHeight
                layoutHeight.constant = newHeight
            }
            else
            {
                layoutHeight.constant = newHeight
                layoutBorderHeight.constant = newBorderHeight
            }
            
            UIView.animate(withDuration:kAnimationDuration)
            { [weak self] in
                
                self?.superview?.layoutIfNeeded()
            }
        }
    }
    
    //MARK: public
    
    func displayImage(image:UIImage?)
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
