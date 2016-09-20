import UIKit

class VChatDisplayAnnotationsPlacer:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var tapGesture:UITapGestureRecognizer!
    weak var itemContainer:UIView!
    private let kItemSize:CGFloat = 40
    private let itemSize_2:CGFloat
    
    init(controller:CChatDisplayAnnotations)
    {
        itemSize_2 = kItemSize / 2.0
        
        super.init(frame:CGRectZero)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
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
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[itemContainer]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[itemContainer]-0-|",
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
        let point:CGPoint = tapGesture.locationInView(self)
        controller.confirmAnnotation(point)
    }
    
    //MARK: public
    
    func addAnnotation()
    {
        tapGesture.enabled = true
        itemContainer.userInteractionEnabled = false
    }
    
    func cancelAnnotation()
    {
        tapGesture.enabled = false
        itemContainer.userInteractionEnabled = true
    }
    
    func reloadItems()
    {
        tapGesture.enabled = false
        
        var count:Int = itemContainer.subviews.count - 1
        while count >= 0
        {
            let subview:UIView = itemContainer.subviews[count]
            subview.removeFromSuperview()
            count -= 1
        }
        
        for item:MChatDisplayAnnotationsItem in controller.controllerChat.model.annotations.items
        {
            let itemLeft:CGFloat = item.xPos - itemSize_2
            let itemTop:CGFloat = item.yPos - itemSize_2
            let subview:VChatDisplayAnnotationsPlacerItem = VChatDisplayAnnotationsPlacerItem(model:item, controller:controller)
            itemContainer.addSubview(subview)
            
            let views:[String:AnyObject] = [
                "itemContainer":itemContainer]
            
            let metrics:[String:AnyObject] = [
                "itemSize":kItemSize,
                "itemLeft":itemLeft,
                "itemTop":itemTop]
            
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-(itemLeft)-[item(itemSize)]",
                options:[],
                metrics:metrics,
                views:views))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-(itemTop)-[item(itemSize)]",
                options:[],
                metrics:metrics,
                views:views))
        }
    }
}