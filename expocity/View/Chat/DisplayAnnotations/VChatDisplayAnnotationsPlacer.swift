import UIKit

class VChatDisplayAnnotationsPlacer:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var tapGesture:UITapGestureRecognizer!
    weak var itemContainer:UIView!
    fileprivate let kItemSize:CGFloat = 40
    fileprivate let itemSize_2:CGFloat
    
    init(controller:CChatDisplayAnnotations)
    {
        itemSize_2 = kItemSize / 2.0
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let itemContainer:UIView = UIView()
        itemContainer.translatesAutoresizingMaskIntoConstraints = false
        itemContainer.clipsToBounds = true
        self.itemContainer = itemContainer
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.actionTap(sender:)))
        self.tapGesture = tapGesture
        
        addGestureRecognizer(tapGesture)
        addSubview(itemContainer)
        
        let views:[String:AnyObject] = [
            "itemContainer":itemContainer]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[itemContainer]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[itemContainer]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        reloadItems()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionTap(sender tapGesture:UITapGestureRecognizer)
    {
        tapGesture.isEnabled = false
        let point:CGPoint = tapGesture.location(in: self)
        let pointX:CGFloat = point.x
        let pointY:CGFloat = point.y
        let imageWidth:CGFloat = bounds.size.width
        let imageHeight:CGFloat = bounds.size.height
        let xPercent:CGFloat = pointX / imageWidth
        let yPercent:CGFloat = pointY / imageHeight
        controller.confirmAnnotation(xPercent, yPercent:yPercent)
    }
    
    //MARK: public
    
    func addAnnotation()
    {
        tapGesture.isEnabled = true
        itemContainer.isUserInteractionEnabled = false
    }
    
    func cancelAnnotation()
    {
        reloadItems()
        tapGesture.isEnabled = false
        itemContainer.isUserInteractionEnabled = true
    }
    
    func reloadItems()
    {
        tapGesture.isEnabled = false
        let screenSize:CGSize = UIScreen.main.bounds.size
        let imageHeight:CGFloat = controller.controllerChat.viewChat.display.maxHeight
        let imageWidth:CGFloat
        
        if screenSize.width > screenSize.height
        {
            imageWidth = screenSize.height
        }
        else
        {
            imageWidth = screenSize.width
        }
        
        var count:Int = itemContainer.subviews.count - 1
        while count >= 0
        {
            let subview:UIView = itemContainer.subviews[count]
            subview.removeFromSuperview()
            count -= 1
        }
        
        for item:MChatDisplayAnnotationsItem in controller.controllerChat.model.annotations.items
        {
            let percentX:CGFloat = item.xPercent
            let percentY:CGFloat = item.yPercent
            let centerX:CGFloat = percentX * imageWidth
            let centerY:CGFloat = percentY * imageHeight
            let itemLeft:CGFloat = centerX - itemSize_2
            let itemTop:CGFloat = centerY - itemSize_2
            let subview:VChatDisplayAnnotationsPlacerItem = VChatDisplayAnnotationsPlacerItem(model:item, controller:controller)
            itemContainer.addSubview(subview)
            
            let views:[String:AnyObject] = [
                "item":subview]
            
            let metrics:[String:AnyObject] = [
                "itemSize":kItemSize as AnyObject,
                "itemLeft":itemLeft as AnyObject,
                "itemTop":itemTop as AnyObject]
            
            itemContainer.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(itemLeft)-[item(itemSize)]",
                options:[],
                metrics:metrics,
                views:views))
            itemContainer.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(itemTop)-[item(itemSize)]",
                options:[],
                metrics:metrics,
                views:views))
        }
    }
}
