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
    
    override func viewWillTransition(to size:CGSize, with coordinator:UIViewControllerTransitionCoordinator)
    {
        UIApplication.shared.keyWindow!.endEditing(true)
        
        super.viewWillTransition(to: size, with:coordinator)
        viewChat.conversation.collection.collectionViewLayout.invalidateLayout()
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewChat.conversation.scrollToBottom()
        }
    }
    
    //MARK: public
    
    func displayImageRect() -> CGRect
    {
        let imageView:UIImageView = viewChat.display.imageView
        let rect:CGRect = imageView.superview!.convert(imageView.frame, to:parentController.viewParent)
        
        return rect
    }
    
    func addTextMine(_ text:String)
    {
        let chatItem:MChatItemTextMine = MChatItemTextMine(text:text)
        let index:Int = model.items.count
        let indexPath:IndexPath = IndexPath(item:index, section:0)
        let indexes:[IndexPath] = [indexPath]
        model.items.append(chatItem)
        viewChat.conversation.didAddChatItem(indexes)
    }
    
    func displayDetail()
    {
        let imageView:UIImageView = viewChat.display.imageView
        let image:UIImage? = imageView.image
        let rect:CGRect = imageView.superview!.convert(imageView.frame, to:parentController.viewParent)
        let displayOption:MChatDisplayOptionsItem = model.displayOption
        let controllerDetail:CChatDisplayDetail = CChatDisplayDetail(image:image, imageRect:rect, displayOption:displayOption)
        parentController.over(controllerDetail)
    }
    
    func displayOptions()
    {
        let controllerOptions:CChatDisplayOptions = CChatDisplayOptions(modelChat:model)
        parentController.over(controllerOptions)
    }
    
    func displayAnnotations()
    {
        let controllerAnnotations:CChatDisplayAnnotations = CChatDisplayAnnotations(controllerChat:self)
        parentController.over(controllerAnnotations)
        viewChat.display.displayAnnotations()
        
        NotificationCenter.default.removeObserver(viewChat)
    }
    
    func removeImage()
    {
        model.annotations.items = []
        viewChat.display.removeImage()
    }
}
