//
//  AirBatteryModel.swift
//  DockBattery
//
//  Created by apple on 2024/2/9.
//

import Foundation

struct Device {
    var hasBattery: Bool = true
    var deviceID: String
    var deviceType: String
    var deviceName: String
    var deviceModel: String?
    var batteryLevel: Int
    var isCharging: Int
    var lastUpdate: Double
    var subDevices: [Device]?
}

class AirBatteryModel {
    static var iDevices: [Device] = []
    static var btDevices: [Device] = []
    static var bleDevices: [Device] = []
    
    static func updateIdevices(_ device: Device) {
        if let index = self.iDevices.firstIndex(where: { $0.deviceID == device.deviceID }) {
            self.iDevices[index] = device
        } else {
            self.iDevices.append(device)
        }
    }
    
    static func updateBTdevices(_ device: Device) {
        if let index = self.btDevices.firstIndex(where: { $0.deviceID == device.deviceID }) {
            self.btDevices[index] = device
        } else {
            self.btDevices.append(device)
        }
    }
    
    static func updateBLEdevice(by: String = "name", _ device: Device) {
        if by == "name" {
            if let index = self.bleDevices.firstIndex(where: { $0.deviceName == device.deviceName }) { self.bleDevices[index] = device } else { self.bleDevices.append(device) }
        }
        if by == "id" {
            if let index = self.bleDevices.firstIndex(where: { $0.deviceID == device.deviceID }) { self.bleDevices[index] = device } else { self.bleDevices.append(device) }
        }
    }
    
    static func getAll() -> [Device] {
        return bleDevices + iDevices + btDevices
    }
    
    static func getAllName() -> [String] {
        var list: [String] = []
        for b in bleDevices + iDevices + btDevices {
            list.append(b.deviceName)
            if let sub = b.subDevices {
                for s in sub {
                    list.append(s.deviceName)
                }
            }
        }
        return list
    }
    
    static func getAllID() -> [String] {
        var list: [String] = []
        for b in bleDevices + iDevices + btDevices {
            list.append(b.deviceID)
            if let sub = b.subDevices {
                for s in sub {
                    list.append(s.deviceID)
                }
            }
        }
        return list
    }
    
    static func getByName(_ name: String) -> Device? {
        for d in bleDevices + iDevices + btDevices {
            if d.deviceName == name { return d }
            if let sub = d.subDevices { for s in sub { if s.deviceName == name { return s } } }
        }
        return nil
    }
    
    static func getByID(_ id: String) -> Device? {
        for d in bleDevices + iDevices + btDevices {
            if d.deviceID == id { return d }
            if let sub = d.subDevices { for s in sub { if s.deviceID == id { return s } } }
        }
        return nil
    }
}