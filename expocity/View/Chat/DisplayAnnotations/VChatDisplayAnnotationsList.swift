import UIKit

class VChatDisplayAnnotationsList:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChatDisplayAnnotations!
    weak var collectionView:UICollectionView!
    private let kInterLineSpace:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 50
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parentController.viewParent.kBarHeight
        let bar:VChatDisplayAnnotationsBar = VChatDisplayAnnotationsBar(controller:controller)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = kInterLineSpace
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kCollectionBottom, 0)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VChatDisplayAnnotationsListCell.self,
            forCellWithReuseIdentifier:
            VChatDisplayAnnotationsListCell.reusableIdentifier())
        self.collectionView = collectionView
        
        addSubview(bar)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "collectionView":collectionView,
            "bar":bar]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[bar(barHeight)]-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MChatDisplayAnnotationsItem
    {
        let item:MChatDisplayAnnotationsItem = controller.controllerChat.model.annotations.items[index.item]
        
        return item
    }
    
    //MARK: col del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let size:CGSize = CGSize(width: width, height: kCellHeight)
        
        return size
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.controllerChat.model.annotations.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MChatDisplayAnnotationsItem = modelAtIndex(index:indexPath)
        let cell:VChatDisplayAnnotationsListCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VChatDisplayAnnotationsListCell.reusableIdentifier(),
            for:indexPath) as! VChatDisplayAnnotationsListCell
        cell.config(model:item, controller:controller)
        
        return cell
    }
}
