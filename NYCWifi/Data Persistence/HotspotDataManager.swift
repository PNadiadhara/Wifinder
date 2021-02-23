//
//  HotspotDataManager.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import Foundation

final class HotspotDataManager {
    private init() {}
    private static let hotspotFileName = "Hotspot.plist"
    private static var hotspots = [Hotspot]()
    
    static func saveHotspot() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: hotspotFileName)
        do {
            let data = try PropertyListEncoder().encode(hotspots)
            try data.write(to: path, options: Data.WritingOptions.atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getHotspots() -> [Hotspot] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: hotspotFileName).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path){
                do {
                    hotspots = try PropertyListDecoder().decode([Hotspot].self, from: data)
                } catch {
                    print("Property List Decoding Error: \(error)")
                }
            } else {
                print("Hotspot Data is nil")
            }
        } else {
            print("\(hotspotFileName) does not exist")
        }
        return hotspots
    }
    
    static func addHotspot(hotspot: Hotspot) {
        hotspots.append(hotspot)
        saveHotspot()
    }
    
    static func deleteHotspot(atIndex: Int){
        hotspots.remove(at: atIndex)
        saveHotspot()
    }
}
