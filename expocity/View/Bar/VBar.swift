import UIKit

class VBar:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var parent:CParent!
    weak var collection:UICollectionView!
    weak var label:UILabel!
    weak var backButton:UIButton!
    private var currentWidth:CGFloat
    private let barHeight:CGFloat
    private let barDelta:CGFloat
    private let model:MMenu
    private let kCellWidth:CGFloat = 80
    private let kAnimationDuration:TimeInterval = 0.3
    private let kWaitingTime:TimeInterval = 1
    
    init(parent:CParent, barHeight:CGFloat, barDelta:CGFloat)
    {
        self.barHeight = barHeight
        self.barDelta = barDelta
        model = MMenu()
        currentWidth = 0
        
        super.init(frame:CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        backgroundColor = UIColor.main()
        self.parent = parent
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        let collection:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(
            VBarCell.self,
            forCellWithReuseIdentifier:
            VBarCell.reusableIdentifier())
        self.collection = collection
        
        let label:UILabel = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(size:18)
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.alpha = 0
        self.label = label
        
        let backButton:UIButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named:"genericBack"), for:UIControlState())
        backButton.imageView!.clipsToBounds = true
        backButton.imageView!.contentMode = UIViewContentMode.center
        backButton.alpha = 0
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25)
        backButton.addTarget(
            self,
            action:#selector(self.actionBack(sender:)),
            for:UIControlEvents.touchUpInside)
        self.backButton = backButton
        
        addSubview(label)
        addSubview(backButton)
        addSubview(collection)
        
        let views:[String:UIView] = [
            "collection":collection,
            "backButton":backButton,
            "label":label]
        
        let metrics:[String:CGFloat] = [
            "barHeight":barHeight,
            "barDelta":barDelta]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-30-[label]-30-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[backButton(60)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collection]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[collection(barHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[backButton(barDelta)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[label(barDelta)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + kWaitingTime)
        {
            let indexPath:IndexPath = IndexPath(item:self.model.current.index, section:0)
            self.collection.selectItem(
                at:indexPath,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition.centeredHorizontally)
        }
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        
        if currentWidth != width
        {
            currentWidth = width
            collection.collectionViewLayout.invalidateLayout()
            
            DispatchQueue.main.async
            {
                let selected:Int = self.model.current.index
                let selectedIndexPath:IndexPath = IndexPath(item:selected, section:0)
                self.collection.scrollToItem(
                    at:selectedIndexPath,
                    at:UICollectionViewScrollPosition.centeredHorizontally,
                    animated:true)
            }
        }
        
        DispatchQueue.main.async
        {
            let currentHeight:CGFloat = self.bounds.maxY
            let deltaHeight:CGFloat = self.barHeight - currentHeight
            let deltaPercent:CGFloat = deltaHeight / self.barDelta
            let alpha:CGFloat = 1 - deltaPercent
            
            if self.model.state.showOptions()
            {
                self.collection.alpha = alpha
            }
            
            if self.model.state.showBackButton()
            {
                self.backButton.alpha = alpha
            }
            
            if self.model.state.showTitle()
            {
                self.label.alpha = alpha
            }
        }
        
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionBack(sender button:UIButton)
    {
        parent.pop()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MMenuItem
    {
        let item:MMenuItem = model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func push(name:String?)
    {
        model.pushed()
        label.text = name
        
        let alphaCollection:CGFloat
        let alphaBackButton:CGFloat
        let alphaLabel:CGFloat
        
        if model.state.showOptions()
        {
            alphaCollection = 1
        }
        else
        {
            alphaCollection = 0
        }
        
        if model.state.showBackButton()
        {
            alphaBackButton = 1
        }
        else
        {
            alphaBackButton = 0
        }
        
        if model.state.showTitle()
        {
            alphaLabel = 1
        }
        else
        {
            alphaLabel = 0
        }
        
        UIView.animate(withDuration:kAnimationDuration)
        {
            self.collection.alpha = alphaCollection
            self.backButton.alpha = alphaBackButton
            self.label.alpha = alphaLabel
        }
    }
    
    func pop()
    {
        model.poped()
        
        let alphaCollection:CGFloat
        let alphaBackButton:CGFloat
        let alphaLabel:CGFloat
        
        if model.state.showOptions()
        {
            alphaCollection = 1
        }
        else
        {
            alphaCollection = 0
        }
        
        if model.state.showBackButton()
        {
            alphaBackButton = 1
        }
        else
        {
            alphaBackButton = 0
        }
        
        if model.state.showTitle()
        {
            alphaLabel = 1
        }
        else
        {
            alphaLabel = 0
        }
        
        UIView.animate(withDuration:kAnimationDuration)
        {
            self.collection.alpha = alphaCollection
            self.backButton.alpha = alphaBackButton
            self.label.alpha = alphaLabel
        }
    }
    
    //MARK: col del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section:Int) -> UIEdgeInsets
    {
        let width:CGFloat = collectionView.bounds.maxX
        let remain:CGFloat = width - kCellWidth
        let margin:CGFloat = remain / 2.0
        let insets:UIEdgeInsets = UIEdgeInsetsMake(0, margin, 0, margin)
        
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
        let count:Int = model.items.count
        
        return count
    }
    
    func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:MMenuItem = modelAtIndex(index:indexPath)
        let cell:VBarCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VBarCell.reusableIdentifier(),
            for:indexPath) as! VBarCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        let item:MMenuItem = modelAtIndex(index:indexPath)
        
        if item !== model.current
        {
            let controller:CController = item.controller()
            
            if item.index < model.current.index
            {
                parent.scrollLeft(controller:controller)
            }
            else
            {
                parent.scrollRight(controller:controller)
            }
            
            model.current = item
            
            collectionView.scrollToItem(
                at:indexPath,
                at:UICollectionViewScrollPosition.centeredHorizontally,
                animated:true)
        }
    }
}
