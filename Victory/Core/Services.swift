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
    
    let realm = try! Realm()
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
    
    let measurement: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let date: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
}

// MARK: AV Service

final class AVService {
    
    private var player: AVAudioPlayer?
    
    func playTada() throws {
        
        if let asset = NSDataAsset(name:"TADA") {
            
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"wav")
                player?.prepareToPlay()
                player?.play()
            } catch let error {
                throw error
            }
        }
    }
    
}
