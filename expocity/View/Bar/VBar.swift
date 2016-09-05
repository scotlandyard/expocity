import UIKit

class VBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var parent:CParent!
    weak var collection:UICollectionView!
    weak var label:UILabel!
    weak var backButton:UIButton!
    private var currentWidth:CGFloat
    private let barHeight:CGFloat
    private let barDelta:CGFloat
    private let model:MMenu
    private let kCellWidth:CGFloat = 74
    
    init(parent:CParent, barHeight:CGFloat, barDelta:CGFloat)
    {
        self.barHeight = barHeight
        self.barDelta = barDelta
        model = MMenu()
        currentWidth = 0
        
        super.init(frame:CGRectZero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.main()
        self.parent = parent
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.clearColor()
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.scrollEnabled = false
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.registerClass(
            VBarCell.self,
            forCellWithReuseIdentifier:
            VBarCell.reusableIdentifier())
        self.collection = collection
        
        let label:UILabel = UILabel()
        label.userInteractionEnabled = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.bold(16)
        label.textAlignment = NSTextAlignment.Center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.whiteColor()
        label.hidden = true
        self.label = label
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.imageView!.image = UIImage(named:"genericBack")
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.Center
        backButton.addTarget(self, action:#selector(self.actionBack(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        backButton.hidden = true
        self.backButton = backButton
        
        addSubview(label)
        addSubview(backButton)
        addSubview(collection)
        
        let views:[String:AnyObject] = [
            "collection":collection,
            "backButton":backButton,
            "label":label]
        
        let metrics:[String:AnyObject] = [
            "barHeight":barHeight,
            "barDelta":barDelta]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-30-[label]-30-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[collection(barheight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[backButton(barDelta)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[label(barDelta)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue())
        { [weak collection, weak model] in
            
            if model != nil
            {
                let indexPath:NSIndexPath = NSIndexPath(forItem:model!.current.index, inSection:0)
                collection?.selectItemAtIndexPath(indexPath, animated:false, scrollPosition:UICollectionViewScrollPosition.CenteredHorizontally)
            }
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        
        if currentWidth != width
        {
            currentWidth = width
            collection.collectionViewLayout.invalidateLayout()
            
            dispatch_async(dispatch_get_main_queue())
            { [weak self] in
                
                if self != nil
                {
                    let selected:Int = self!.model.current.index
                    let selectedIndexPath:NSIndexPath = NSIndexPath(forItem:selected, inSection:0)
                    self!.collection.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:true)
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue())
        {
            let currentHeight:CGFloat = self.bounds.maxY
            let deltaHeight:CGFloat = self.barHeight - currentHeight
            let deltaPercent:CGFloat = deltaHeight / self.barDelta
            let alpha:CGFloat = 1 - deltaPercent
            self.collection.alpha = alpha
        }
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MMenuItem
    {
        let item:MMenuItem = model.items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAtIndex section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.maxX
        let remain:CGFloat = width - kCellWidth
        let margin:CGFloat = remain / 2.0
        let insets:UIEdgeInsets = UIEdgeInsetsMake(0, margin, 0, margin)
        
        return insets
    }
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSizeMake(kCellWidth, height)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MMenuItem = modelAtIndex(indexPath)
        let cell:VBarCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VBarCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VBarCell
        cell.config(item)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        let item:MMenuItem = modelAtIndex(indexPath)
        
        if item !== model.current
        {
            let controller:CController = item.controller()
            
            if item.index < model.current.index
            {
                parent.scrollLeft(controller)
            }
            else
            {
                parent.scrollRight(controller)
            }
            
            model.current = item
            
            collectionView.scrollToItemAtIndexPath(
                indexPath,
                atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally,
                animated:true)
        }
    }
}