import UIKit

class VHome:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CHome!
    weak var collection:UICollectionView!
    weak var loader:VMainLoader!
    private let kCollectionBottom:CGFloat = 40
    private let kInterLine:CGFloat = 2
    
    convenience init(controller:CHome)
    {
        self.init()
        backgroundColor = UIColor.whiteColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let loader:VMainLoader = VMainLoader()
        self.loader = loader
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.scrollDirection = UICollectionViewScrollDirection.Vertical
        flow.minimumLineSpacing = kInterLine
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kCollectionBottom, 0)
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clearColor()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        collection.hidden = true
        collection.registerClass(
            VHomeCellTitle.self,
            forCellWithReuseIdentifier:
            VHomeCellTitle.reusableIdentifier())
        collection.registerClass(
            VHomeCellCreate.self,
            forCellWithReuseIdentifier:
            VHomeCellCreate.reusableIdentifier())
        self.collection = collection
        
        addSubview(collection)
        addSubview(loader)
        
        let views:[String:AnyObject] = [
            "loader":loader,
            "collection":collection]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MHomeItem
    {
        let item:MHomeItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        loader.stopAnimating()
        collection.hidden = false
    }
    
    //MARK: col del
    
    func scrollViewDidScroll(scrollView:UIScrollView)
    {
        controller.parent.viewParent.scrollDidScroll(scrollView)
    }
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let item:MHomeItem = modelAtIndex(indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSizeMake(width, item.cellHeight)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MHomeItem = modelAtIndex(indexPath)
        let cell:VHomeCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            item.reusableIdentifier,
            forIndexPath:
            indexPath) as! VHomeCell
        cell.config(item)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, shouldHighlightItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        let item:MHomeItem = modelAtIndex(indexPath)
        let highlightable:Bool = item.selectable
        
        return highlightable
    }
    
    func collectionView(collectionView:UICollectionView, shouldSelectItemAtIndexPath indexPath:NSIndexPath) -> Bool
    {
        let item:MHomeItem = modelAtIndex(indexPath)
        let selectable:Bool = item.selectable
        
        return selectable
    }
}