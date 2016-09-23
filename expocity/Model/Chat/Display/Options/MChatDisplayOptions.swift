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
    
    func selectItem(index:Int)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
            
            if self != nil
            {
                self!.selected = index
                self!.modelChat.displayOption = self!.items[index]
                
                NSNotificationCenter.defaultCenter().postNotificationName(
                    NSNotification.Name.ChatDisplayOptionChanged.rawValue,
                    object:nil)
            }
        }
    }
}