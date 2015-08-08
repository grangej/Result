//
//  ResultTests.swift
//  ResultTests
//
//  Created by John Grange on 8/7/15.
//  Copyright © 2015 John Grange. All rights reserved.
//

import XCTest
@testable import Result

enum TestError: ErrorType {
    
    case ErrorTest
}

class ResultTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func returnSuccess(shouldFail: Bool) -> Result<String, TestError> {
        
        if shouldFail {
            
            return Result.Failure(TestError.ErrorTest)
        }
        else {
            
            return Result.Success("Success")

        }
    }
    
    func testSucessReturn() {
        
        let result = returnSuccess(false)
        
        switch result {
            
        case .Success(let stringValue):
            print(stringValue)
        default:
            XCTFail("Should not return error")
        }
    }
    
    
    func testFailureReturn() {
        
        let result = returnSuccess(true)
        
        switch result {
            
        case .Success:
            XCTFail("Should return error")
        case .Failure(let error):
            print(error)
        }
    }
    
    func testThrowError() {
        
        do {
            
            let result = try returnSuccess(true).throwit()
            
            print(result)

            XCTFail("Should throw error")
        }
        catch {
            
            print(error)
        }
        
    }
    
    func testThrowSuccess() {
        
        do {
            
            let result = try returnSuccess(false).throwit()
            
            print(result)
            
        }
        catch {
            
            print(error)
            
            XCTFail("Should not throw error")

        }
        
    }
    
    
    func testCaptureThrowError() {
        
 
        let result: Result<NSData, NSError> = Result(try NSData(contentsOfFile: "data.bin", options: []))
        
        switch result {
            
        case .Success:
            XCTFail("Should produce error")
        case .Failure(let error):
            print("Error: \(error)")
        }
        
    
    }
    
    func throwResult(shouldFail: Bool) throws -> String {
        
        if shouldFail {
            
            throw TestError.ErrorTest
        }
        else {
            
            return "Result successful"
        }
    }
    
    func testCaptureThrowSuccess() {
        
        let result: Result<String, NSError> = Result(try throwResult(false))
        
        switch result {
            
        case .Success(let stringResult):
            print(stringResult)
        case .Failure(let error):
            
            print(error)
            XCTFail("Should not produce error")
        }
    }
}
