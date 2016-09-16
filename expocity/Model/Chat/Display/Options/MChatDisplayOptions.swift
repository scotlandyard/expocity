import Foundation

class MChatDisplayOptions
{
    let items:[MChatDisplayOptionsItem]
    var selected:Int
    
    init(displayOption:MChatDisplayOptionsItem)
    {
        let itemFit:MChatDisplayOptionsItemFit = MChatDisplayOptionsItemFit()
        let itemFill:MChatDisplayOptionsItemFill = MChatDisplayOptionsItemFill()
        let itemCenter:MChatDisplayOptionsItemCenter = MChatDisplayOptionsItemCenter()
        
        items = [
            itemFit,
            itemFill,
            itemCenter
        ]
        
        var selected:Int = 0
        
        for item:MChatDisplayOptionsItem in items
        {
            if displayOption.contentMode == item.contentMode
            {
                break
            }
            
            selected += 1
        }
        
        self.selected = selected
    }
}