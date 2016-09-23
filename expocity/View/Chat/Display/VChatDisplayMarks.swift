import UIKit

class VChatDisplayMarks:UIView
{
    weak var controller:CChat!
    weak var button:UIButton?
    private let kItemSize:CGFloat = 50
    private let itemSize_2:CGFloat
    
    init(controller:CChat)
    {
        itemSize_2 = kItemSize / 2.0
        
        super.init(frame:CGRectZero)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
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
        self.button?.removeFromSuperview()
        let imageWidth:CGFloat = bounds.maxX
        let imageHeight:CGFloat = bounds.maxY
        
        let button:UIButton = UIButton()
        button.backgroundColor = UIColor.clearColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(self, action:#selector(self.actionButton(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        self.button = button
        
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
        
        for modelItem:MChatDisplayAnnotationsItem in controller.model.annotations.items
        {
            let viewItem:VChatDisplayMarksItem = VChatDisplayMarksItem(controller:controller)
            button.addSubview(viewItem)
            
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