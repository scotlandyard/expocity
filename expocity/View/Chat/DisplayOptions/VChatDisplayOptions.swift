import UIKit

class VChatDisplayOptions:UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    weak var controller:CChatDisplayOptions!
    weak var collectionView:UICollectionView!
    weak var blur:UIView!
    weak var base:UIView!
    private let kAnimationDuration:TimeInterval = 0.3
    private let kCornerRadius:CGFloat = 4
    private let kBaseMarginVertical:CGFloat = 40
    private let kBaseMarginHorizontal:CGFloat = 10
    private let kButtonDoneHeight:CGFloat = 40
    private let kWaitingSelected:UInt64 = 150
    
    convenience init(controller:CChatDisplayOptions)
    {
        self.init()
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        self.controller = controller
        
        let blurEffect:UIBlurEffect = UIBlurEffect(style:UIBlurEffectStyle.light)
        let visualEffect:UIVisualEffectView = UIVisualEffectView(effect:blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        visualEffect.isUserInteractionEnabled = false
        
        let blur:UIView = UIView()
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.alpha = 0
        self.blur = blur
        
        let base:UIView = UIView()
        base.backgroundColor = UIColor.white
        base.translatesAutoresizingMaskIntoConstraints = false
        base.clipsToBounds = true
        base.layer.borderWidth = 1
        base.layer.borderColor = UIColor(white:0, alpha:0.1).cgColor
        base.layer.cornerRadius = kCornerRadius
        
        let buttonDone:UIButton = UIButton()
        buttonDone.backgroundColor = UIColor.complement()
        buttonDone.translatesAutoresizingMaskIntoConstraints = false
        buttonDone.setTitleColor(UIColor.white, for:UIControlState())
        buttonDone.setTitleColor(UIColor(white:1, alpha:0.2), for:UIControlState.highlighted)
        buttonDone.setTitle(NSLocalizedString("VChatDisplayOptions_buttonDone", comment:""), for:UIControlState())
        buttonDone.titleLabel!.font = UIFont.bold(size:14)
        buttonDone.addTarget(self, action:#selector(self.actionDone(sender:)), for:UIControlEvents.touchUpInside)
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flow.headerReferenceSize = CGSize.zero
        flow.footerReferenceSize = CGSize.zero
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.sectionInset = UIEdgeInsets.zero
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let collectionView:UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout:flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.clipsToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            VChatDisplayOptionsCell.self,
            forCellWithReuseIdentifier:
            VChatDisplayOptionsCell.reusableIdentifier())
        self.collectionView = collectionView
        
        blur.addSubview(visualEffect)
        blur.addSubview(base)
        base.addSubview(buttonDone)
        base.addSubview(collectionView)
        addSubview(blur)
        
        let views:[String:UIView] = [
            "visualEffect":visualEffect,
            "blur":blur,
            "base":base,
            "buttonDone":buttonDone,
            "collectionView":collectionView]
        
        let metrics:[String:CGFloat] = [
            "baseMarginVertical":kBaseMarginVertical,
            "baseMarginHorizontal":kBaseMarginHorizontal,
            "buttonDoneHeight":kButtonDoneHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-(baseMarginHorizontal)-[base]-(baseMarginHorizontal)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[buttonDone]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[collectionView]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[visualEffect]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[blur]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(baseMarginVertical)-[base]-(baseMarginVertical)-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-0-[collectionView]-0-[buttonDone(buttonDoneHeight)]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        
        let selected:IndexPath = IndexPath(item:controller.model.selected, section:0)
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + Double(NSEC_PER_MSEC * kWaitingSelected))
        { [weak self] in
            
            self?.collectionView.selectItem(
                at:selected,
                animated:false,
                scrollPosition:UICollectionViewScrollPosition())
        }
    }
    
    override func layoutSubviews()
    {
        collectionView.collectionViewLayout.invalidateLayout()
        super.layoutSubviews()
    }
    
    //MARK: actions
    
    func actionDone(sender button:UIButton)
    {
        controller.parentController.dismiss()
    }
    
    //MARK: private
    
    private func modelAtIndex(index:IndexPath) -> MChatDisplayOptionsItem
    {
        let item:MChatDisplayOptionsItem = controller.model.items[index.item]
        
        return item
    }
    
    //MARK: public
    
    func animateBlur()
    {
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.blur.alpha = 1
        }
    }
    
    //MARK: collection del
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        let width:CGFloat = collectionView.bounds.maxX
        let height:CGFloat = collectionView.bounds.maxY
        let count:Int = controller.model.items.count
        let countFloat:CGFloat = CGFloat(count)
        let size:CGSize
        
        if width > height
        {
            let cellWidth:CGFloat = width / countFloat
            size = CGSize(width:cellWidth, height:height)
        }
        else
        {
            let cellHeight:CGFloat = height / countFloat
            size = CGSize(width:width, height:cellHeight)
        }
        
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
        let item:MChatDisplayOptionsItem = modelAtIndex(index:indexPath)
        let cell:VChatDisplayOptionsCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: VChatDisplayOptionsCell.reusableIdentifier(),
            for:indexPath) as! VChatDisplayOptionsCell
        cell.config(model:item)
        
        return cell
    }
    
    func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath:IndexPath)
    {
        controller.model.selectItem(index:index.item)
    }
}
