//
//  Holiday.swift
//  restAPI
//
//  Created by Red Nguyen on 9/13/21.
//

import Foundation

struct HolidayResponse:Decodable {
    public var response:Holidays
}

struct Holidays:Decodable {
    public var holidays:[HolidayDetail]
}

struct HolidayDetail: Decodable {
    public var name: String
    public var date: DateInfo
}

struct DateInfo:Decodable {
    public var iso:String
    
}
