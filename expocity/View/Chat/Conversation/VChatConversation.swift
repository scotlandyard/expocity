import UIKit

class VChatConversation:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collection:UICollectionView!
    fileprivate let kCollectionBottom:CGFloat = 10
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionTop:CGFloat = controller.parent.viewParent.kBarHeight
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(collectionTop, 0, kCollectionBottom, 0)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(
            VChatConversationCellTextMine.self,
            forCellWithReuseIdentifier:
            VChatConversationCellTextMine.reusableIdentifier())
        self.collection = collection
        
        addSubview(collection)
        
        let views:[String:AnyObject] = [
            "collection":collection]
        
        let metrics:[String:AnyObject] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    fileprivate func modelAtIndex(_ index:IndexPath) -> MChatItem
    {
        let item:MChatItem = controller.model.items[(index as NSIndexPath).item]
        
        return item
    }
    
    //MARK: public
    
    func didAddChatItem(_ indexes:[IndexPath])
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.collection.insertItems(at: indexes)
            self?.scrollToBottom()
        }
    }
    
    func scrollToBottom()
    {
        let count:Int = controller.model.items.count
        
        if count > 0
        {
            let lastItem:Int = count - 1
            let indexPath:IndexPath = IndexPath(item:lastItem, section:0)
            collection.scrollToItem(at: indexPath, at:UICollectionViewScrollPosition.top, animated:true)
        }
    }
    
    //MARK: col del
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        controller.parent.viewParent.scrollDidScroll(scrollView)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MChatItem = modelAtIndex(indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = item.heightForCollection(width)
        let size:CGSize = CGSize(width: width, height: height)
        
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MChatItem = modelAtIndex(indexPath)
        let cell:VChatConversationCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.reusableIdentifier,
            for:
            indexPath) as! VChatConversationCell
        cell.config(item, controller:controller)
        
        return cell
    }
}
