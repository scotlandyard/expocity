import UIKit

class VChatDisplayMarks:UIView
{
    weak var controller:CChat!
    weak var itemsBase:UIView?
    private let kItemSize:CGFloat = 50
    private let itemSize_2:CGFloat
    
    init(controller:CChat)
    {
        itemSize_2 = kItemSize / 2.0
        
        super.init(frame:CGRectZero)
        clipsToBounds = false
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let button:UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        addSubview(button)
        
        let views:[String:AnyObject] = [
            "button":button]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: actions
    
    func actionButton(sender button:UIButton)
    {
        controller.displayDetail()
    }
    
    //MARK: public
    
    func addItems()
    {
        let screenSize:CGSize = UIScreen.mainScreen().bounds.size
        let imageWidth:CGFloat
        let imageHeight:CGFloat = controller.viewChat.display.maxHeight
        
        if screenSize.width < screenSize.height
        {
            imageWidth = screenSize.width
        }
        else
        {
            imageWidth = screenSize.height
        }
        
        self.itemsBase?.removeFromSuperview()
        
        let itemsBase:UIView = UIView()
        self.itemsBase = itemsBase
        addSubview(itemsBase)
        
        let views:[String:AnyObject] = [
            "itemsBase":itemsBase]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[itemsBase]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[itemsBase]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        for modelItem:MChatDisplayAnnotationsItem in controller.model.annotations.items
        {
            let viewItem:VChatDisplayMarksItem = VChatDisplayMarksItem(controller:controller)
            itemsBase.addSubview(viewItem)
            
            let percentX:CGFloat = modelItem.xPercent * imageWidth
            let percentY:CGFloat = modelItem.yPercent * imageHeight
            let itemLeft:CGFloat = percentX - itemSize_2
            let itemTop:CGFloat = percentY - itemSize_2
            
            let itemViews:[String:AnyObject] = [
                "viewItem":viewItem]
            
            let itemMetrics:[String:AnyObject] = [
                "itemSize":kItemSize,
                "itemLeft":itemLeft,
                "itemTop":itemTop]
            
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-(itemLeft)-[viewItem(itemSize)]",
                options:[],
                metrics:itemMetrics,
                views:itemViews))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-(itemTop)-[viewItem(itemSize)]",
                options:[],
                metrics:itemMetrics,
                views:itemViews))
        }
    }
}