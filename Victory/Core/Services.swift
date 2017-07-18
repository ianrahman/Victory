//
//  Services.swift
//  Victory
//
//  Created by Ian Rahman on 6/15/17.
//  Copyright © 2017 Evergreen Labs. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation
import AVFoundation

// MARK: - Services

final class Services {
    
    let realm: Realm = {
        
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    migration.enumerateObjects(ofType: Run.className()) { oldObject, newObject in
                        let id = oldObject!["id"] as! Int
                        newObject!["id"] = UUID().uuidString
                    }
                }
        })
        
        return try! Realm()
    }()
    let configuration = ConfigurationService()
    let location = LocationService()
    let formatter = FormatterService()
    let av = AVService()
    
}

// MARK: - Configuration Service

struct ConfigurationService {
    
    let tableViewRowHeight: CGFloat = 55
    let titleFont = UIFont(name: "Helvetica Neue", size: 24)!
    let bodyFont = UIFont(name: "Helvetica Neue", size: 20)!
    let detailFont = UIFont(name: "Helvetica Neue", size: 16)!
    
}

// MARK: - Location Service

final class LocationService {
    
    let manager = CLLocationManager()
    
}

// MARK: - Formatter Service

final class FormatterService {
    
    private lazy var measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private lazy var dateFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    func formatted(measurement: Measurement<UnitLength>) -> String {
        return measurementFormatter.string(from: measurement)
    }
    
    func formatted(time: TimeInterval) -> String {
        return dateFormatter.string(from: time) ?? "0:00:00"
    }
    
}

// MARK: AV Service

final class AVService {
    
    private var player: AVAudioPlayer?
    
    func playSound(_ name: String = "TADA") throws {
        guard let asset = NSDataAsset(name: name) else { throw avError.assetError }
        player = try AVAudioPlayer(data:asset.data, fileTypeHint:"wav")
        player?.prepareToPlay()
        player?.play()
    }
    
}

private enum avError: Error {
        
        case assetError
    
}

extension avError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .assetError:
            return NSLocalizedString("Asset not found.", comment: "Check that provided name is correct.")
        }
    }
    
}
