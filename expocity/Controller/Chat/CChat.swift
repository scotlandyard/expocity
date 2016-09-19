import UIKit

class CChat:CController
{
    weak var viewChat:VChat!
    let model:MChat
    
    init(model:MChat)
    {
        self.model = model
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = model.title
    }
    
    override func loadView()
    {
        let viewChat:VChat = VChat(controller:self)
        self.viewChat = viewChat
        view = viewChat
    }
    
    override func viewWillTransitionToSize(size:CGSize, withTransitionCoordinator coordinator:UIViewControllerTransitionCoordinator)
    {
        UIApplication.sharedApplication().keyWindow!.endEditing(true)
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator:coordinator)
        viewChat.conversation.collection.collectionViewLayout.invalidateLayout()
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            self?.viewChat.conversation.scrollToBottom()
        }
    }
    
    //MARK: public
    
    func displayImageRect() -> CGRect
    {
        let imageView:UIImageView = viewChat.display.imageView
        let rect:CGRect = imageView.superview!.convertRect(imageView.frame, toView:parent.viewParent)
        
        return rect
    }
    
    func addTextMine(text:String)
    {
        let chatItem:MChatItemTextMine = MChatItemTextMine(text:text)
        let index:Int = model.items.count
        let indexPath:NSIndexPath = NSIndexPath(forItem:index, inSection:0)
        let indexes:[NSIndexPath] = [indexPath]
        model.items.append(chatItem)
        viewChat.conversation.didAddChatItem(indexes)
    }
    
    func displayDetail(imageView:UIImageView)
    {
        let image:UIImage? = imageView.image
        let rect:CGRect = imageView.superview!.convertRect(imageView.frame, toView:parent.viewParent)
        let displayOption:MChatDisplayOptionsItem = model.displayOption
        let controllerDetail:CChatDisplayDetail = CChatDisplayDetail(image:image, imageRect:rect, displayOption:displayOption)
        parent.over(controllerDetail)
    }
    
    func displayOptions()
    {
        let controllerOptions:CChatDisplayOptions = CChatDisplayOptions(modelChat:model)
        parent.over(controllerOptions)
    }
    
    func displayAnnotations()
    {
        let controllerAnnotations:CChatDisplayAnnotations = CChatDisplayAnnotations(controllerChat:self)
        parent.over(controllerAnnotations)
    }
}