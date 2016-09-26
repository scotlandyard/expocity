import UIKit

class VHome:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CHome!
    weak var collection:UICollectionView!
    weak var loader:VMainLoader!
    private let kCollectionBottom:CGFloat = 40
    private let kWaitingTime:Double = 1
    
    convenience init(controller:CHome)
    {
        self.init()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let loader:VMainLoader = VMainLoader()
        self.loader = loader
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(controller.parentController.viewParent.kBarHeight, 0, kCollectionBottom, 0)
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = true
        collection.register(
            VHomeCellTitle.self,
            forCellWithReuseIdentifier:
            VHomeCellTitle.reusableIdentifier())
        collection.register(
            VHomeCellCreate.self,
            forCellWithReuseIdentifier:
            VHomeCellCreate.reusableIdentifier())
        self.collection = collection
        
        addSubview(collection)
        addSubview(loader)
        
        let views:[String:UIView] = [
            "loader":loader,
            "collection":collection]
        
        let metrics:[String:CGFloat] = [:]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[loader]-0-|",
            options:[],
            metrics:metrics,
            views:views))
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
    
    override func layoutSubviews()
    {
        collection.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MHomeItem
    {
        let item:MHomeItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func sessionLoaded()
    {
        loader.stopAnimating()
        collection.isHidden = false
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
