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
        let firebaseRoom:FDatabaseModelRoom = mHome!.room()
        let roomName:String = firebaseRoom.name
        
        XCTAssertFalse(roomName.isEmpty, "Room name is empty")
    }
}
