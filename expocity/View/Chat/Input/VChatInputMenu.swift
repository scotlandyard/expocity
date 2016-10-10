import UIKit

class VChatInputMenu:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    let model:MChatMenu
    private let kCellWidth:CGFloat = 50
    private let kWaitingTime:TimeInterval = 1
    
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
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            VChatInputMenuCell.self,
            forCellWithReuseIdentifier:
            VChatInputMenuCell.reusableIdentifier())
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
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
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
            collectionView.reloadData()
        }
    }
    
    func modeTypeReady()
    {
        let currentStatus:MChatMenuStatusTypeReady? = model.status as? MChatMenuStatusTypeReady
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusTypeReady()
            collectionView.reloadData()
        }
    }
    
    func modeStandby()
    {
        let currentStatus:MChatMenuStatusStandby? = model.status as? MChatMenuStatusStandby
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusStandby()
            collectionView.reloadData()
        }
    }
    
    func modeStandbyImage()
    {
        let currentStatus:MChatMenuStatusStandbyImage? = model.status as? MChatMenuStatusStandbyImage
        
        if currentStatus == nil
        {
            model.status = MChatMenuStatusStandbyImage()
            collectionView.reloadData()
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
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + kWaitingTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
