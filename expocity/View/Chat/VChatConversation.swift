import UIKit

class VChatConversation:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collection:UICollectionView!
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clearColor()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsZero
        flow.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let collection:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clearColor()
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        collection.registerClass(
            VChatConversationCellTextMine.self,
            forCellWithReuseIdentifier:
            VChatConversationCellTextMine.reusableIdentifier())
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
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MChatItem
    {
        let item:MChatItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func didAddChatItem(indexes:[NSIndexPath])
    {
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.collection.insertItemsAtIndexPaths(indexes)
        }
    }
    
    //MARK: col del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let item:MChatItem = modelAtIndex(indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = item.heightForCollection(collectionView)
        let size:CGSize = CGSizeMake(width, height)
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
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
        let item:MChatItem = modelAtIndex(indexPath)
        let cell:VChatConversationCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            item.reusableIdentifier,
            forIndexPath:
            indexPath) as! VChatConversationCell
        
        return cell
    }
}