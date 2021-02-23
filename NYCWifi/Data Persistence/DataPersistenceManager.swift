//
//  DataPersistenceManager.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import Foundation

final class DataPersistenceManager {
    private init() {}
    
    static func documentsDirectory() -> URL  {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
