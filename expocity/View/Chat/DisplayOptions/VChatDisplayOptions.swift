import UIKit

class VChatDisplayOptions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChatDisplayOptions!
    weak var collection:UICollectionView!
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
        
        blur.addSubview(visualEffect)
        blur.addSubview(base)
        base.addSubview(buttonDone)
        addSubview(blur)
        
        let views:[String:AnyObject] = [
            "visualEffect":visualEffect,
            "blur":blur,
            "base":base,
            "buttonDone":buttonDone]
        
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
            "V:[buttonDone(buttonDoneHeight)]-0-|",
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
        let size:CGSize
        
        if width > height
        {
            
        }
        else
        {
            
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