import UIKit

class VChatConversation:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    private let kCollectionBottom:CGFloat = 10
    
    convenience init(controller:CChat)
    {
        self.init()
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let collectionTop:CGFloat = controller.parentController.viewParent.kBarHeight
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(collectionTop, 0, kCollectionBottom, 0)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VChatConversationCellTextMine.self,
            forCellWithReuseIdentifier:
            VChatConversationCellTextMine.reusableIdentifier())
        self.collectionView = collectionView
        
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MChatItem
    {
        let item:MChatItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func didAddChatItem(indexes:[IndexPath])
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.collectionView.insertItems(at:indexes)
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
            collectionView.scrollToItem(
                at:indexPath,
                at:UICollectionViewScrollPosition.top,
                animated:true)
        }
    }
    
    //MARK: col del
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        controller.parentController.viewParent.scrollDidScroll(scroll:scrollView)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let screenSize:CGSize = UIScreen.main.bounds.size
        let item:MChatItem = modelAtIndex(index:indexPath)
        let width:CGFloat = screenSize.width
        let height:CGFloat = item.heightForCollection(width:width)
        let size:CGSize = CGSize(width:width, height:height)
        
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
        let item:MChatItem = modelAtIndex(index:indexPath)
        let cell:VChatConversationCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: item.reusableIdentifier,
            for:indexPath) as! VChatConversationCell
        cell.config(model:item, controller:controller)
        
        return cell
    }
}
