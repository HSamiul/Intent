//
//  IntentTests.swift
//  IntentTests
//
//  Created by Samiul Hoque on 8/10/22.
//

import XCTest
@testable import Intent

final class IntentTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBlockTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let date = Date(timeIntervalSince1970: 5000)
        
        let block = Block(date: date)
        XCTAssert(block.formattedTime() == formatter.string(from: date))
        
        let block2 = Block(date: date + 1000)
        XCTAssert(block2.formattedTime() == formatter.string(from: date + 1000))
        
        let block3 = Block(date: date - 2000)
        XCTAssert(block3.formattedTime() == formatter.string(from: date - 2000))
    }
    
    func testBlockBulletCleanUp() {
        let bullet1 = Bullet("\n")
        let bullet2 = Bullet("")
        let bullet3 = Bullet("     text   ")
        let bullet4 = Bullet("    ")
        let bullet5 = Bullet("   \n")
        let bullet6 = Bullet("more text\n")
        
        let block = Block(bullets: [bullet6, bullet3, bullet2, bullet1, bullet4, bullet5])
        
        block.cleanUpBullets()
        XCTAssert(block.bullets == [bullet6, bullet3])
        XCTAssert(bullet3.text == "text")
        XCTAssert(bullet6.text == "more text")
    }
    
    func testBlockEdit() {
        let bullet1 = Bullet("bullet 1")
        let bullet2 = Bullet("bullet 2")
        let date = Date(timeIntervalSince1970: 1000)
        let block = Block("original name", date: date, bullets: [bullet1, bullet2])
        
        let bullet3 = Bullet("bullet 3")
        block.update(name: "edited name", date: date + 2000, bullets: [bullet1, bullet3])
        XCTAssert(block.name == "edited name")
        XCTAssert(block.date == date + 2000)
        XCTAssert(block.bullets == [bullet1, bullet3])
    }
    
    func testDayAddBlock() {
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        
        let day = Day(date: tomorrow)
        XCTAssert(day.blocks.isEmpty)
        
        XCTAssert(day.addBlock(name: "block1", date: Date() - 999999999, bullets: []) == false)
        XCTAssert(day.addBlock(name: "block2", date: Date() + 999999999, bullets: []) == false)
        XCTAssert(day.addBlock(name: "block3", date: Date() + 60 * 60 * 24, bullets: []) == true)
        
        XCTAssert(day.blocks.count == 1)
    }
}
