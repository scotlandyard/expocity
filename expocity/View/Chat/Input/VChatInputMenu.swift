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
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.bounces = false
        collection.backgroundColor = UIColor.clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            VChatInputMenuCell.self,
            forCellWithReuseIdentifier:
            VChatInputMenuCell.reusableIdentifier())
        self.collection = collection
        
        addSubview(collection)
        
        let views:[String:UIView] = [
            "collection":collection]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MChatMenuItem
    {
        let item:MChatMenuItem = model.status.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func rightMargin() -> CGFloat
    {
        let count:Int = model.status.items.count
        let cellsWidth:CGFloat = CGFloat(count) * kCellWidth
        
        return cellsWidth
    }
    
    func modeTyping()
    {
        let currentStatus:MChatMenuStatusTyping? = model.status as? MChatMenuStatusTyping
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusTyping()
            collection.reloadData()
        }
    }
    
    func modeTypeReady()
    {
        let currentStatus:MChatMenuStatusTypeReady? = model.status as? MChatMenuStatusTypeReady
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusTypeReady()
            collection.reloadData()
        }
    }
    
    func modeStandby()
    {
        let currentStatus:MChatMenuStatusStandby? = model.status as? MChatMenuStatusStandby
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusStandby()
            collection.reloadData()
        }
    }
    
    func modeStandbyImage()
    {
        let currentStatus:MChatMenuStatusStandbyImage? = model.status as? MChatMenuStatusStandbyImage
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusStandbyImage()
            collection.reloadData()
        }
    }
    
    //MARK: col del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let totalWidth:CGFloat = collectionView.bounds.maxX
        let margin:CGFloat = rightMargin()
        let remain:CGFloat = totalWidth - margin
        let insets:UIEdgeInsets = UIEdgeInsetsMake(0, remain, 0, 0)
        
        return insets
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let height:CGFloat = collectionView.bounds.maxY
        let size:CGSize = CGSize(width:kCellWidth, height:height)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.status.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MChatMenuItem = modelAtIndex(index:indexPath)
        let cell:VChatInputMenuCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VChatInputMenuCell.reusableIdentifier(),
            for:indexPath) as! VChatInputMenuCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MChatMenuItem = modelAtIndex(index:indexPath)
        item.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + Double(NSEC_PER_SEC))
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
