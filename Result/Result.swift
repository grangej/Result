//
//  Result.swift
//  Result
//
//  Created by John Grange on 8/7/15.
//  Copyright © 2015 SD Networks. All rights reserved.
//
//
import Foundation

/**
Simple ResultType enum, we will build slowly on this to keep things CLEAR and easy to read.

- Success: Success case that will hold a value of any type
- Failure: Failure case that will hold an error constrainted to type ErrorType
*/
public enum Result<T, Error: ErrorType> {
    
    case Success(T)
    case Failure(Error)
    
    var value: T? {
        
        switch self {
        case .Success(let value):
            return value
        
        case .Failure(_):
            return nil
        }
        
    }
    
    var error: Error? {
        
        switch self {
        case .Success(_):
            return nil
        case .Failure(let error):
            return error
        }
    }
    
    /// Constructs a success wrapping a `value`.
    public init(value: T) {
        self = .Success(value)
    }
    
    /// Constructs a failure wrapping an `error`.
    public init(error: Error) {
        self = .Failure(error)
    }
    
    /**
    Construct a result from a function that throws an error, useful in completion blocks
    
    i.e. let result: Result<NSData, NSError> = Result(try NSData(contentsOfFile: "data.bin", options: []))
    
    :param: f function to do a try catch on
    
    :returns: a Result with either a failure or value of type returned by the function
    */
    public init(@autoclosure _ f: () throws -> T) {
        do {
            self = .Success(try f())
        } catch {
            self = .Failure(error as! Error)
        }
    }
    

    /**
    Convert Result to a throwable function
    
    Exampe:
    
    do {
        let json = try jsonResult.throwit()
    } catch {
        print(error)
    }
    
    :returns: a function that you can use in a try / catch block
    
    */
    func throwit() throws -> T {
        
        switch self {
            
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error      }
    }
    
    

}
infix operator ?! {
    associativity right
    precedence 131
}

func ?! <T>(optional: T?, @autoclosure error: () -> ErrorType) throws -> T {
    if let value = optional {
        return value
    } else {
        throw error()
    }
}




