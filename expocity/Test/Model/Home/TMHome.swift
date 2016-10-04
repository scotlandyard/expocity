import XCTest
@testable import expocity

class TMHome:XCTestCase
{
    var mHome:MHome?
    
    override func setUp()
    {
        super.setUp()
        
        mHome = MHome()
    }
    
    override func tearDown()
    {
        mHome = nil
        
        super.tearDown()
    }
    
    //MARK: tests
    
    func testEmptyRoomName()
    {
        mHome.itm
    }
}
