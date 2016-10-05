import UIKit

class VHome:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CHome!
    weak var collectionView:UICollectionView!
    weak var loader:VMainLoader!
    private let kCollectionBottom:CGFloat = 40
    private let kWaitingTime:TimeInterval = 1
    
    convenience init(controller:CHome)
    {
        self.init()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        let loader:VMainLoader = VMainLoader()
        self.loader = loader
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(controller.parentController.viewParent.kBarHeight, 0, kCollectionBottom, 0)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VHomeCellTitle.self,
            forCellWithReuseIdentifier:
            VHomeCellTitle.reusableIdentifier())
        collectionView.register(
            VHomeCellAccess.self,
            forCellWithReuseIdentifier:
            VHomeCellAccess.reusableIdentifier())
        collectionView.register(
            VHomeCellCreate.self,
            forCellWithReuseIdentifier:
            VHomeCellCreate.reusableIdentifier())
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(loader)
        
        let views:[String:UIView] = [
            "loader":loader,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
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
        
        startLoading()
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeItem
    {
        let item:MHomeItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func stopLoading()
    {
        loader.stopAnimating()
        collectionView.isHidden = false
    }
    
    func startLoading()
    {
        loader.startAnimating()
        collectionView.isHidden = true
    }
    
    //MARK: col del
    
    func scrollViewDidScroll(_ scrollView:UIScrollView)
    {
        controller.parentController.viewParent.scrollDidScroll(scroll:scrollView)
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:item.cellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
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
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let cell:VHomeCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:item.reusableIdentifier,
            for:indexPath) as! VHomeCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldHighlightItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let highlightable:Bool = item.selectable
        
        return highlightable
    }
    
    func collectionView(_ collectionView:UICollectionView, shouldSelectItemAt indexPath:IndexPath) -> Bool
    {
        let item:MHomeItem = modelAtIndex(index:indexPath)
        let selectable:Bool = item.selectable
        
        return selectable
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let cell:VHomeCell = collectionView.cellForItem(at:indexPath) as! VHomeCell
        cell.selected(controller:controller)
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + kWaitingTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
