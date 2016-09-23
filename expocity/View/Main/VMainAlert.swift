import UIKit

class VMainAlert:UIView
{
    enum VMainAlertType
    {
        case Annotation
        case Warning
        case Error
    }
    
    let kHeight:CGFloat = 80
    weak var layoutTop:NSLayoutConstraint!
    private let kIconAnnotation:String = ""
    private let kIconWarning:String = ""
    private let kIconError:String = ""
    private let kImageViewWidth:CGFloat = 50
    private let kLabelMarginRight:CGFloat = 10
    private let kMarginTop:CGFloat = 20
    
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
        }
    }
    
    convenience init(message:String, type:VMainAlertType)
    {
        self.init()
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.complement()
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.regular(16)
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
        
        let views:[String:AnyObject] = [
            "imageView":imageView,
            "label":label]
        
        let metrics:[String:AnyObject] = [
            "imageWidth":kImageViewWidth,
            "labelMarginRight":kLabelMarginRight,
            "marginTop":kMarginTop]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[imageView(imageWidth)]-0-[label]-(labelMarginRight)-|",
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
    }
    
    //MARK: private
    
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
}