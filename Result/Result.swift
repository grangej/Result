//
//  Result.swift
//  Result
//
//  Created by John Grange on 8/7/15.
//  Copyright © 2015 SD Networks. All rights reserved.
//

import Foundation

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
}

//MARK: - Extend result to convert to a throwable error
extension Result {
    
    func throwit() throws -> T {
        
        switch self {
            
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error
        }
    }
}