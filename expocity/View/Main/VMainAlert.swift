import UIKit

class VMainAlert:UIView
{
    enum Type
    {
        case annotation
        case warning
        case error
    }
    
    let kHeight:CGFloat = 90
    weak var layoutTop:NSLayoutConstraint!
    weak var timer:Timer?
    private let kIconAnnotation:String = "alertAnnotation"
    private let kIconWarning:String = ""
    private let kIconError:String = ""
    private let kImageViewWidth:CGFloat = 40
    private let kMarginTop:CGFloat = 20
    private let kAnimationDuration:TimeInterval = 0.2
    private let kAlertDuration:TimeInterval = 3
    private let kBorderHeight:CGFloat = 1
    
    class func Show(message:String, type:Type)
    {
        DispatchQueue.main.async
        {
            let mainView:UIView = UIApplication.shared.keyWindow!.rootViewController!.view
            let alert:VMainAlert = VMainAlert(message:message, type:type)
            
            mainView.addSubview(alert)
            
            let views:[String:UIView] = [
                "alert":alert]
            
            let metrics:[String:CGFloat] = [
                "alertHeight":alert.kHeight]
            
            mainView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"H:|-0-[alert]-0-|",
                options:[],
                metrics:metrics,
                views:views))
            mainView.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"V:[alert(alertHeight)]",
                options:[],
                metrics:metrics,
                views:views))
            
            let alertInitialTop:CGFloat = -alert.kHeight
            
            alert.layoutTop = NSLayoutConstraint(
                item:alert,
                attribute:NSLayoutAttribute.top,
                relatedBy:NSLayoutRelation.equal,
                toItem:mainView,
                attribute:NSLayoutAttribute.top,
                multiplier:1,
                constant:alertInitialTop)
            
            mainView.addConstraint(alert.layoutTop)
            mainView.layoutIfNeeded()
            alert.animateAlert()
        }
    }
    
    convenience init(message:String, type:Type)
    {
        self.init()
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor(white:0, alpha:0.1)
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.bold(size:18)
        label.textColor = UIColor.white
        label.text = message
        
        let imageView:UIImageView = UIImageView()
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.center
        setIcon(imageView:imageView, type:type)
        
        addSubview(imageView)
        addSubview(label)
        addSubview(border)
        
        let views:[String:UIView] = [
            "imageView":imageView,
            "label":label,
            "border":border]
        
        let metrics:[String:CGFloat] = [
            "imageWidth":kImageViewWidth,
            "marginTop":kMarginTop,
            "borderHeight":kBorderHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[imageView(imageWidth)]-0-[label]-(imageWidth)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(marginTop)-[imageView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(marginTop)-[label]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[border(borderHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        
        layoutTop.constant = -kHeight
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            self.superview!.layoutIfNeeded()
        })
        { (done:Bool) in
            
            self.removeFromSuperview()
        }
    }
    
    private func setIcon(imageView:UIImageView, type:Type)
    {
        let imageName:String
        
        switch type
        {
            case Type.annotation:
            
                imageName = kIconAnnotation
                
                break
            
            case Type.warning:
                
                imageName = kIconWarning
                
                break
            
            case Type.error:
            
                imageName = kIconError
                
                break
        }
        
        imageView.image = UIImage(named:imageName)
    }
    
    private func animateAlert()
    {
        layoutTop.constant = 0
        
        UIView.animate(withDuration:kAnimationDuration, animations:
        {
            self.superview!.layoutIfNeeded()
        })
        { (done:Bool) in
            
            self.timer = Timer.scheduledTimer(
                timeInterval:self.kAlertDuration,
                target:self,
                selector:#selector(self.timeOut(sender:)),
                userInfo:nil,
                repeats:false)
        }
    }
}
