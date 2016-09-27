import UIKit

class VChatEmojiKeyboard:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChat!
    weak var collectionView:UICollectionView!
    weak var layoutHeight:NSLayoutConstraint!
    let model:MChatEmojiKeyboard
    private let kNumberOfLines:CGFloat = 2
    private let kBorderHeight:CGFloat = 1
    private let kMaxHeight:CGFloat = 230
    private let kCellWidth:CGFloat = 80
    private let kFooterHeight:CGFloat = 70
    private let kAnimationDuration:TimeInterval = 6
    
    init(controller:CChat)
    {
        model = MChatEmojiKeyboard()
        
        super.init(frame:CGRect.zero)
        clipsToBounds = true
        backgroundColor = UIColor.collectionBackground()
        translatesAutoresizingMaskIntoConstraints = false
        self.controller = controller
        
        let cellsHeight:CGFloat = kMaxHeight - kFooterHeight
        let cellLineHeight:CGFloat = cellsHeight / kNumberOfLines
        
        let border:UIView = UIView()
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.bubbleMine()
        border.translatesAutoresizingMaskIntoConstraints = false
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize(width:0, height:kFooterHeight)
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.itemSize = CGSize(width:kCellWidth, height:cellLineHeight)
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VChatEmojiKeyboardCell.self,
            forCellWithReuseIdentifier:
            VChatEmojiKeyboardCell.reusableIdentifier())
        collectionView.register(
            VChatEmojiKeyboardFooter.self,
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter,
            withReuseIdentifier:
            VChatEmojiKeyboardFooter.reusableIdentifier())
        
        addSubview(border)
        addSubview(collectionView)
        
        let views:[String:UIView] = [
            "border":border,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "borderHeight":kBorderHeight,
            "collectionHeight":kMaxHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[border]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[border(borderHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView(collectionHeight)]",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MChatEmojiKeyboardItem
    {
        let item:MChatEmojiKeyboardItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func animateKeyboard(show:Bool)
    {
        let newHeight:CGFloat
        
        if show
        {
            newHeight = kMaxHeight
        }
        else
        {
            newHeight = 0
        }
        
        layoutHeight.constant = newHeight
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.superview?.layoutIfNeeded()
        }
    }
    
    //MARK: collection del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let itemsCount:Int = model.items.count
        let itemsCountFloat:CGFloat = CGFloat(itemsCount)
        let itemsPerLine:CGFloat = ceil(itemsCountFloat / kNumberOfLines)
        let itemsWidth:CGFloat = itemsPerLine * kCellWidth
        let totalWidth:CGFloat = collectionView.bounds.maxX
        let remainWidth:CGFloat = totalWidth - itemsWidth
        let marginWidth:CGFloat = remainWidth / 2.0
        let sectionInsets:UIEdgeInsets = UIEdgeInsets(top:0, left:marginWidth, bottom:0, right:marginWidth)
        
        return sectionInsets
    }
    
    func numberOfSections(in collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, viewForSupplementaryElementOfKind kind:String, at indexPath:IndexPath) -> UICollectionReusableView
    {
        let footer:VChatEmojiKeyboardFooter = collectionView.dequeueReusableSupplementaryView(
            ofKind:kind,
            withReuseIdentifier:VChatEmojiKeyboardFooter.reusableIdentifier(),
            for:indexPath) as! VChatEmojiKeyboardFooter
        footer.controller = controller
        
        return footer
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MChatEmojiKeyboardItem = modelAtIndex(index:indexPath)
        let cell:VChatEmojiKeyboardCell = collectionView.dequeueReusableCell(
            withReuseIdentifier:VChatEmojiKeyboardCell.reusableIdentifier(),
            for:indexPath) as! VChatEmojiKeyboardCell
        cell.config(model:item)
        
        return cell
    }
}
