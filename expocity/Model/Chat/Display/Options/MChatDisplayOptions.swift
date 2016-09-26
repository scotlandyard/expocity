import Foundation

class MChatDisplayOptions
{
    weak var modelChat:MChat!
    let items:[MChatDisplayOptionsItem]
    var selected:Int
    
    init(modelChat:MChat)
    {
        self.modelChat = modelChat
        let itemFit:MChatDisplayOptionsItemFit = MChatDisplayOptionsItemFit()
        let itemFill:MChatDisplayOptionsItemFill = MChatDisplayOptionsItemFill()
        let itemCenter:MChatDisplayOptionsItemCenter = MChatDisplayOptionsItemCenter()
        
        items = [
            itemFit,
            itemFill,
            itemCenter
        ]
        
        var selected:Int = 0
        let currentDisplayOption:MChatDisplayOptionsItem = modelChat.displayOption
        
        for item:MChatDisplayOptionsItem in items
        {
            if currentDisplayOption.contentMode == item.contentMode
            {
                break
            }
            
            selected += 1
        }
        
        self.selected = selected
    }
    
    //MARK: public
    
    func selectItem(_ index:Int)
    {
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            if self != nil
            {
                self!.selected = index
                self!.modelChat.displayOption = self!.items[index]
                
                NotificationCenter.default.post(name: Notification.NotificationName.ChatDisplayOptionChanged, object: nil)
                
                NotificationCenter.default.post(
                    name: Notification.Name(rawValue: Notification.Name.ChatDisplayOptionChanged.rawValue),
                    object:nil)
            }
        }
    }
}
