import Foundation

class MChatDisplayOptions
{
    weak var model:MChat!
    let items:[MChatDisplayOptionsItem]
    var selected:Int
    
    init(model:MChat)
    {
        self.model = model
        let itemFit:MChatDisplayOptionsItemFit = MChatDisplayOptionsItemFit()
        let itemFill:MChatDisplayOptionsItemFill = MChatDisplayOptionsItemFill()
        let itemCenter:MChatDisplayOptionsItemCenter = MChatDisplayOptionsItemCenter()
        
        items = [
            itemFit,
            itemFill,
            itemCenter
        ]
        
        var selected:Int = 0
        let currentDisplayOption:MChatDisplayOptionsItem = model.displayOption
        
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
}