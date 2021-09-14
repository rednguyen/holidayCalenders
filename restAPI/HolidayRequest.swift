//
//  HolidayRequest.swift
//  restAPI
//
//  Created by Red Nguyen on 9/13/21.
//

import Foundation

enum HolidayError:Error {
    case noDateAvailable
    case canNotProcess
}

struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "e9bbc68b3ebd3b03234fdac100284ed40d3de1f9"
    
    init(countryCode:String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resouceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=2019"
        guard let resourceURL = URL(string: resouceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDateAvailable))
                return
            }
            
            
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                print(holidaysResponse)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcess))
            }
        }
        dataTask.resume()
    }
}
