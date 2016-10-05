import UIKit

class VRooms:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CRooms!
    weak var spinner:VMainLoader?
    weak var collectionView:UICollectionView!
    private let kCollectionFooter:CGFloat = 80
    private let kCellHeight:CGFloat = 54
    private let kLineSpacing:CGFloat = 1
    private let kDeselectTime:TimeInterval = 1
    
    convenience init(controller:CRooms)
    {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.collectionBackground()
        clipsToBounds = true
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        
        let spinner:VMainLoader = VMainLoader()
        self.spinner = spinner
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize(width:0, height:kCollectionFooter)
        flow.minimumLineSpacing = kLineSpacing
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.sectionInset = UIEdgeInsets.zero
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            VRoomsCell.self,
            forCellWithReuseIdentifier:
            VRoomsCell.reusableIdentifier())
        collectionView.register(
            VRoomsFooter.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VRoomsFooter.reusableIdentifier())
        self.collectionView = collectionView
        
        addSubview(collectionView)
        addSubview(spinner)
        
        let views:[String:UIView] = [
            "collectionView":collectionView,
            "spinner":spinner]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(barHeight)-[spinner]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MRoomsItem
    {
        let item:MRoomsItem = controller.model!.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func roomsReload()
    {
        spinner?.removeFromSuperview()
        collectionView.reloadData()
    }
    
    //MARK: collection delegate
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width:width, height:kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int
        
        if controller.model == nil
        {
            count = 0
        }
        else
        {
            count = controller.model!.items.count
        }
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MRoomsItem = modelAtIndex(index:indexPath)
        let cell:VRoomsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VRoomsCell.reusableIdentifier(),
            for:indexPath) as! VRoomsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MRoomsItem = modelAtIndex(index:indexPath)
        
        
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + kDeselectTime)
        { [weak collectionView] in
            
            collectionView?.selectItem(
                at:nil,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
}
