import UIKit

class VChatInputMenu:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collection:UICollectionView!
    let model:MChatMenu
    private let kCellWidth:CGFloat = 50
    
    init(controller:CChat)
    {
        model = MChatMenu()
        
        super.init(frame:CGRectZero)
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.scrollEnabled = false
        collection.bounces = false
        collection.backgroundColor = UIColor.clearColor()
        collection.dataSource = self
        collection.delegate = self
        collection.registerClass(
            VChatInputMenuCell.self,
            forCellWithReuseIdentifier:
            VChatInputMenuCell.reusableIdentifier())
        self.collection = collection
        
        addSubview(collection)
        
        let views:[String:AnyObject] = [
            "collection":collection]
        
        let metrics:[String:AnyObject] = [:]
        
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
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MChatMenuItem
    {
        let item:MChatMenuItem = model.items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAtIndex section:Int) -> UIEdgeInsets
    {
        let totalWidth:CGFloat = collectionView.bounds.maxX
        let count:Int = model.items.count
        let cellsWidth:CGFloat = CGFloat(count) * kCellWidth
        let remain:CGFloat = totalWidth - cellsWidth
        let insets:UIEdgeInsets = UIEdgeInsetsMake(0, remain, 0, 0)
        
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
        let item:MChatMenuItem = modelAtIndex(indexPath)
        let cell:VChatInputMenuCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VChatInputMenuCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VChatInputMenuCell
        cell.config(item)
        
        return cell
    }
    
    func collectionView(collectionView:UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath)
    {
        
    }
}