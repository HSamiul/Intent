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
        
        let block = Block()
        XCTAssert(block.formattedTime() == formatter.string(from: Date.now))
        
        let block2 = Block(date: Date.now + 1000)
        XCTAssert(block2.formattedTime() == formatter.string(from: Date.now + 1000))
        
        let block3 = Block(date: Date.now - 2000)
        XCTAssert(block3.formattedTime() == formatter.string(from: Date.now - 2000))
    }
    
    func testBlockBulletFiltering() {
        let bullet1 = Bullet("\n")
        let bullet2 = Bullet("")
        let bullet3 = Bullet("text")
        let bullet4 = Bullet("    ")
        let bullet5 = Bullet("   \n")
        let bullet6 = Bullet("more text")
        
        let block = Block(bullets: [bullet6, bullet3, bullet2, bullet1, bullet4, bullet5])
        block.filterBullets()
        XCTAssert(block.bullets == [bullet6, bullet3])
    }
    
    
}
