import Foundation

class MHome
{
    let items:[MHomeItem]
    
    init()
    {
        let itemTitle:MHomeItemTitle = MHomeItemTitle()
        let itemCreate:MHomeItemCreate = MHomeItemCreate()
        
        items = [
            itemTitle,
            itemCreate
        ]
    }
}