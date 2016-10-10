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
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
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
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.addTarget(
            self,
            action:#selector(actionButton(sender:)),
            for:UIControlEvents.touchUpInside)
        self.button = button
        
        addSubview(button)
        
        let views:[String:UIView] = [
            "button":button]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[button]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        for modelItem:MChatDisplayAnnotationsItem in controller.model.annotations.items
        {
            let viewItem:VChatDisplayMarksItem = VChatDisplayMarksItem(controller:controller, model:modelItem)
            button.addSubview(viewItem)
            
            let percentX:CGFloat = modelItem.xPercent * imageWidth
            let percentY:CGFloat = modelItem.yPercent * imageHeight
            let itemLeft:CGFloat = percentX - itemSize_2
            let itemTop:CGFloat = percentY - itemSize_2
            
            let itemViews:[String:UIView] = [
                "viewItem":viewItem]
            
            let itemMetrics:[String:CGFloat] = [
                "itemSize":kItemSize,
                "itemLeft":itemLeft,
                "itemTop":itemTop]
            
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"H:|-(itemLeft)-[viewItem(itemSize)]",
                options:[],
                metrics:itemMetrics,
                views:itemViews))
            addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat:"V:|-(itemTop)-[viewItem(itemSize)]",
                options:[],
                metrics:itemMetrics,
                views:itemViews))
        }
    }
}
