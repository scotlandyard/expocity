import UIKit

class VChatDisplayAnnotationsList:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChatDisplayAnnotations!
    weak var collectionView:UICollectionView!
    private let kInterLineSpace:CGFloat = 1
    private let kCollectionBottom:CGFloat = 20
    private let kCellHeight:CGFloat = 40
    
    convenience init(controller:CChatDisplayAnnotations)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let barHeight:CGFloat = controller.parent.viewParent.kBarHeight
        let bar:VChatDisplayAnnotationsBar = VChatDisplayAnnotationsBar(controller:controller)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = kInterLineSpace
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsMake(0, 0, kCollectionBottom, 0)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(
            VChatDisplayAnnotationsListCell.self,
            forCellWithReuseIdentifier:
            VChatDisplayAnnotationsListCell.reusableIdentifier())
        self.collectionView = collectionView
        
        addSubview(bar)
        addSubview(collectionView)
        
        let views:[String:AnyObject] = [
            "collectionView":collectionView,
            "bar":bar]
        
        let metrics:[String:AnyObject] = [
            "barHeight":barHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[bar]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[bar(barHeight)]-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
}