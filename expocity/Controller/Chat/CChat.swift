import UIKit

class CChat:CController
{
    weak var viewChat:VChat!
    let roomId:String
    var model:MChat!
    
    init(roomId:String)
    {
        self.roomId = roomId
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)
        
        if model == nil
        {
            DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
            { [weak self] in
                
                self?.loadModel()
            }
        }
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
        
        super.viewWillTransition(to:size, with:coordinator)
        
        DispatchQueue.main.async
        { [weak self] in
            
            self?.viewChat.conversation.scrollToBottom()
        }
    }
    
    //MARK: private
    
    private func loadModel()
    {
        let roomReference:String = FDatabase.Parent.room.rawValue
        let path:String = String(
            format:"%@/%@",
            roomReference,
            roomId)
        
        FMain.sharedInstance.database.listenOnce(
            path:path,
            modelType:FDatabaseModelRoom.self)
        { [weak self] (object:FDatabaseModelRoom) in
            
            self?.model = MChat(firebaseRoom:object)
            self?.modelLoaded()
        }
    }
    
    private func modelLoaded()
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.chatReady()
        }
    }
    
    private func chatReady()
    {
        title = model.title
        viewChat.chatLoaded()
    }
    
    private func addChatItem(chatItem:MChatItem)
    {
        let index:Int = model.items.count
        let indexPath:IndexPath = IndexPath(item:index, section:0)
        let indexes:[IndexPath] = [indexPath]
        model.items.append(chatItem)
        viewChat.conversation.didAddChatItem(indexes:indexes)
    }
    
    //MARK: public
    
    func displayImageRect() -> CGRect
    {
        let imageView:UIImageView = viewChat.display.imageView
        let rect:CGRect = imageView.superview!.convert(imageView.frame, to:parentController.viewParent)
        
        return rect
    }
    
    func addTextMine(text:String)
    {
        let chatItem:MChatItemTextMine = MChatItemTextMine(text:text)
        addChatItem(chatItem:chatItem)
    }
    
    func addEmojiMine(image:UIImage)
    {
        let chatItem:MChatItemEmojiMine = MChatItemEmojiMine(image:image)
        addChatItem(chatItem:chatItem)
    }
    
    func displayDetail()
    {
        let imageView:UIImageView = viewChat.display.imageView
        let image:UIImage? = imageView.image
        let rect:CGRect = imageView.superview!.convert(imageView.frame, to:parentController.viewParent)
        let displayOption:MChatDisplayOptionsItem = model.displayOption
        let controllerDetail:CChatDisplayDetail = CChatDisplayDetail(image:image, imageRect:rect, displayOption:displayOption)
        parentController.over(controller:controllerDetail)
    }
    
    func displayOptions()
    {
        let controllerOptions:CChatDisplayOptions = CChatDisplayOptions(modelChat:model)
        parentController.over(controller:controllerOptions)
    }
    
    func displayAnnotations()
    {
        let controllerAnnotations:CChatDisplayAnnotations = CChatDisplayAnnotations(controllerChat:self)
        parentController.over(controller:controllerAnnotations)
        viewChat.display.displayAnnotations()
        
        NotificationCenter.default.removeObserver(viewChat)
    }
    
    func removeImage()
    {
        model.annotations.items = []
        viewChat.display.removeImage()
    }
}
