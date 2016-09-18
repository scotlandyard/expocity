import UIKit

class VChatDisplayOptions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChatDisplayOptions!
    weak var collectionView:UICollectionView!
    weak var blur:UIView!
    weak var base:UIView!
    private let kAnimationDuration:NSTimeInterval = 0.3
    private let kCornerRadius:CGFloat = 4
    private let kBaseMarginVertical:CGFloat = 40
    private let kBaseMarginHorizontal:CGFloat = 10
    private let kButtonDoneHeight:CGFloat = 40
    
    convenience init(controller:CChatDisplayOptions)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clearColor()
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.Light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.userInteractionEnabled = false
        
        let blur:UIView = UIView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.alpha = 0
        self.blur = blur
        
        let base:UIView = UIView()
        base.backgroundColor = UIColor.whiteColor()
        base.translatesAutoresizingMaskIntoConstraints = false
        base.clipsToBounds = true
        base.layer.borderWidth = 1
        base.layer.borderColor = UIColor(white:0, alpha:0.1).CGColor
        base.layer.cornerRadius = kCornerRadius
        
        let buttonDone:UIButton = UIButton()
        buttonDone.backgroundColor = UIColor.complement()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.setTitleColor(UIColor.whiteColor(), forState:UIControlState.Normal)
        buttonDone.setTitleColor(UIColor(white:1, alpha:0.2), forState:UIControlState.Highlighted)
        buttonDone.setTitle(NSLocalizedString("VChatDisplayOptions_buttonDone", comment:""), forState:UIControlState.Normal)
        buttonDone.titleLabel!.font = UIFont.bold(14)
        buttonDone.addTarget(self, action:#selector(self.actionDone(sender:)), forControlEvents:UIControlEvents.TouchUpInside)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSizeZero
        flow.footerReferenceSize = CGSizeZero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsetsZero
        flow.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRectZero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(
            VChatDisplayOptionsCell.self,
            forCellWithReuseIdentifier:
            VChatDisplayOptionsCell.reusableIdentifier())
        self.collectionView = collectionView
        
        blur.addSubview(visualEffect)
        blur.addSubview(base)
        base.addSubview(buttonDone)
        base.addSubview(collectionView)
        addSubview(blur)
        
        let views:[String:AnyObject] = [
            "visualEffect":visualEffect,
            "blur":blur,
            "base":base,
            "buttonDone":buttonDone,
            "collectionView":collectionView]
        
        let metrics:[String:AnyObject] = [
            "baseMarginVertical":kBaseMarginVertical,
            "baseMarginHorizontal":kBaseMarginHorizontal,
            "buttonDoneHeight":kButtonDoneHeight]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(baseMarginHorizontal)-[base]-(baseMarginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[buttonDone]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(baseMarginVertical)-[base]-(baseMarginVertical)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-0-[collectionView]-0-[buttonDone(buttonDoneHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        controller.parent.dismiss()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:NSIndexPath) -> MChatDisplayOptionsItem
    {
        let item:MChatDisplayOptionsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func animateBlur()
    {
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.blur.alpha = 1
        }
    }
    
    //MARK: collection del
    
    func collectionView(collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let count:Int = controller.model.items.count
        let countFloat:CGFloat = CGFloat(count)
        let size:CGSize
        
        if width > height
        {
            let cellWidth:CGFloat = width / countFloat
            size = CGSizeMake(cellWidth, height)
        }
        else
        {
            let cellHeight:CGFloat = height / countFloat
            size = CGSizeMake(width, cellHeight)
        }
        
        return size
    }
    
    func numberOfSectionsInCollectionView(collectionView:UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
    {
        let count:Int = controller.model.items.count
        
        return count
    }
    
    func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let item:MChatDisplayOptionsItem = modelAtIndex(indexPath)
        let cell:VChatDisplayOptionsCell = collectionView.dequeueReusableCellWithReuseIdentifier(
            VChatDisplayOptionsCell.reusableIdentifier(),
            forIndexPath:
            indexPath) as! VChatDisplayOptionsCell
        cell.config(item)
        
        return cell
    }
}