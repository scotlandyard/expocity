import UIKit

class VMainAlert:UIView
{
    enum VMainAlertType
    {
        case Annotation
        case Warning
        case Error
    }
    
    let kHeight:CGFloat = 90
    weak var layoutTop:NSLayoutConstraint!
    weak var timer:NSTimer?
    private let kIconAnnotation:String = "alertAnnotation"
    private let kIconWarning:String = ""
    private let kIconError:String = ""
    private let kImageViewWidth:CGFloat = 40
    private let kMarginTop:CGFloat = 20
    private let kAnimationDuration:NSTimeInterval = 0.2
    private let kAlertDuration:NSTimeInterval = 3
    private let kBorderHeight:CGFloat = 1
    
    class func Show(message:String, type:VMainAlertType)
    {
        dispatch_async(dispatch_get_main_queue())
        {
            let mainView:UIView = UIApplication.sharedApplication().keyWindow!.rootViewController!.view
            let alert:VMainAlert = VMainAlert(message:message, type:type)
            
            mainView.addSubview(alert)
            
            let views:[String:AnyObject] = [
                "alert":alert]
            
            let metrics:[String:AnyObject] = [
                "alertHeight":alert.kHeight]
            
            mainView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-0-[alert]-0-|",
                options:[],
                metrics:metrics,
                views:views))
            mainView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
                "V:[alert(alertHeight)]",
                options:[],
                metrics:metrics,
                views:views))
            
            let alertInitialTop:CGFloat = -alert.kHeight
            
            alert.layoutTop = NSLayoutConstraint(
                item:alert,
                attribute:NSLayoutAttribute.Top,
                relatedBy:NSLayoutRelation.Equal,
                toItem:mainView,
                attribute:NSLayoutAttribute.Top,
                multiplier:1,
                constant:alertInitialTop)
            
            mainView.addConstraint(alert.layoutTop)
            mainView.layoutIfNeeded()
            alert.animateAlert()
        }
    }
    
    convenience init(message:String, type:VMainAlertType)
    {
        self.init()
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        
        let border:UIView = UIView()
        border.userInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.bold(18)
        label.textColor = UIColor.whiteColor()
        label.text = message
        
        let imageView:UIImageView = UIImageView()
        imageView.userInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.Center
        setIcon(imageView, type:type)
        
        addSubview(imageView)
        addSubview(label)
        addSubview(border)
        
        let views:[String:AnyObject] = [
            "imageView":imageView,
            "label":label,
            "border":border]
        
        let metrics:[String:AnyObject] = [
            "imageWidth":kImageViewWidth,
            "marginTop":kMarginTop,
            "borderHeight":kBorderHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[imageView(imageWidth)]-0-[label]-(imageWidth)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(marginTop)-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(marginTop)-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[border(borderHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    func timeOut(sender timer:NSTimer)
    {
        timer.invalidate()
        
        layoutTop.constant = -kHeight
        
        UIView.animateWithDuration(kAnimationDuration, animations:
        {
            self.superview!.layoutIfNeeded()
        })
        { (done) in
            
            self.removeFromSuperview()
        }
    }
    
    private func setIcon(imageView:UIImageView, type:VMainAlertType)
    {
        let imageName:String
        
        switch type
        {
            case VMainAlertType.Annotation:
            
                imageName = kIconAnnotation
                
                break
            
            case VMainAlertType.Warning:
                
                imageName = kIconWarning
                
                break
            
            case VMainAlertType.Error:
            
                imageName = kIconError
                
                break
        }
        
        imageView.image = UIImage(named:imageName)
    }
    
    private func animateAlert()
    {
        layoutTop.constant = 0
        
        UIView.animateWithDuration(kAnimationDuration, animations:
        {
            self.superview!.layoutIfNeeded()
        })
        { (done) in
            
            self.timer = NSTimer.scheduledTimerWithTimeInterval(
                self.kAlertDuration,
                target:self,
                selector:#selector(self.timeOut(sender:)),
                userInfo:nil,
                repeats:false)
        }
    }
}