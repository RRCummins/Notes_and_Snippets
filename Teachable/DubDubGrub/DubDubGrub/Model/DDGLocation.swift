//
//  DDGLocation.swift
//  DubDubGrub
//
//  Created by Ryan Cummins on 4/22/22.
//

import CloudKit

struct DDGLocation {
    let ckRecordID: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset
    let bannerAsset: CKAsset
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String
}
