import UIKit

class VChatDisplayAnnotations:UIView
{
    weak var controller:CChatDisplayAnnotations!
    weak var shadeTop:VChatDisplayAnnotationsShade!
    weak var shadeBottom:VChatDisplayAnnotationsShade!
    weak var list:VChatDisplayAnnotationsList!
    weak var layoutShadeTopHeight:NSLayoutConstraint!
    weak var layoutShadeBottomHeight:NSLayoutConstraint!
    private let kAnimateDuration:NSTimeInterval = 0.3
    private let kDelayLayout:UInt64 = 100
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let shadeTop:VChatDisplayAnnotationsShade = VChatDisplayAnnotationsShade()
        self.shadeTop = shadeTop
        
        let shadeBottom:VChatDisplayAnnotationsShade = VChatDisplayAnnotationsShade()
        self.shadeBottom = shadeBottom
        
        let list:VChatDisplayAnnotationsList = VChatDisplayAnnotationsList(controller:controller)
        self.list = list
        
        shadeTop.addSubview(list)
        addSubview(shadeTop)
        addSubview(shadeBottom)
        
        let views:[String:AnyObject] = [
            "shadeTop":shadeTop,
            "shadeBottom":shadeBottom,
            "list":list]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadeTop]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[list]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[shadeTop]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[shadeBottom]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[list]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutShadeTopHeight = NSLayoutConstraint(
            item:shadeTop,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        layoutShadeBottomHeight = NSLayoutConstraint(
            item:shadeBottom,
            attribute:NSLayoutAttribute.Height,
            relatedBy:NSLayoutRelation.Equal,
            toItem:nil,
            attribute:NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutShadeTopHeight)
        addConstraint(layoutShadeBottomHeight)
        
        layoutShades()
    }
    
    override func layoutSubviews()
    {
        let delayLayout:UInt64 = self.kDelayLayout
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.shadeTop.alpha = 0
            self?.shadeBottom.alpha = 0
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC * delayLayout)), dispatch_get_main_queue())
            { [weak self] in
                
                self?.layoutShades()
                self?.animateShades()
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func layoutShades()
    {
        let imageRect:CGRect = controller.controllerChat.displayImageRect()
        let screenRect:CGRect = UIScreen.mainScreen().bounds
        let topHeight:CGFloat = imageRect.minY
        let bottomHeight:CGFloat = screenRect.maxY - imageRect.maxY
        
        layoutShadeTopHeight.constant = topHeight
        layoutShadeBottomHeight.constant = bottomHeight
    }
    
    private func modelAtIndex(index:NSIndexPath) -> MChatDisplayAnnotationsItem
    {
        let item:MChatDisplayAnnotationsItem = controller.controllerChat.model.annotations.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func animateShades()
    {
        UIView.animateWithDuration(kAnimateDuration)
        { [weak self] in
            
            self?.shadeTop.alpha = 1
            self?.shadeBottom.alpha = 1
        }
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section:Int) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSizeMake(width, kCellHeight)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.controllerChat.model.annotations.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MChatDisplayAnnotationsItem = modelAtIndex(indexPath)
        let cell:VChatDisplayAnnotationsCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VChatDisplayAnnotationsCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VChatDisplayAnnotationsCell
        cell.config(item)
        
        return cell
    }
}