import Foundation

class MChatDisplayOptions
{
    let items:[MChatDisplayOptionsItem]
    
    init()
    {
        let itemFit:MChatDisplayOptionsItemFit = MChatDisplayOptionsItemFit()
        let itemFill:MChatDisplayOptionsItemFill = MChatDisplayOptionsItemFill()
        let itemCenter:MChatDisplayOptionsItemCenter = MChatDisplayOptionsItemCenter()
        
        items = [
            itemFit,
            itemFill,
            itemCenter
        ]
    }
}