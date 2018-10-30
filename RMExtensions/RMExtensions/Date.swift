//
//  Date.swift
//  Ouch
//
//  Created by Rahul Mane on 08/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import Foundation

private let TIME_ZONE = "Asia/Singapore"

struct DateFormats {
    static let     FULL_DATE_FORMAT                    = "yyyy-MM-dd hh:mm a"
    static let     YYYY_DD_MM_FORMAT                   = "yyyy-dd-MM"
    static let     DD_MMM_YYYY_FORMAT                  = "dd MMM yyyy"
    static let     DATE_FORMAT_DD_MM_YYYY              = "dd-MM-yyyy"
    static let     DATE_FORMAT_MM_DD_YYYY              = "MMM dd, yyyy"
    static let     DATE_FORMAT_MMMM_DD_YYYY            = "MMMM dd, yyyy"
    static let     DATE_FORMAT_MMMM_DD_YYYY_HH_MM      = "MMM dd yyyy, hh:mm a"
    static let     DATE_FORMAT_DD_YYYY                 = "dd, yyyy"
    static let     DATE_FORMAT_YYYY_MM_DD              = "yyyy-MM-dd"
    static let     DATE_FORMAT_DD_MMM_YY               = "dd-MMM-yy"
    static let     DATE_FORMAT_DD_MMM                  = "dd-MMM"
    static let     DATE_FORMAT_MMM_YYYY                = "MMM yyyy"
    static let     DATE_FORMAT_YYYY_MM_DD_HH_MM_SS     = "yyyy-MM-dd HH:mm:ss"
    static let     DATE_FORMAT_YYYY_MM_DD_T_HH_MM_SS_Z = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let     DATE_FORMAT_YYYY_MM_DD_T_HH_MM_SS   = "yyyy-MM-dd'T'HH:mm:ss"
    static let     DATE_FORMAT_YYYY_MM                 = "yyyy-MM"
    static let     DATE_FORMAT_MM_YY                   = "MM-yy"
    static let     DATE_FORMAT_MM_YYYY                 = "MM/yyyy"
    static let     DATE_FORMAT_DD_MMMM_YYYY_HH_MM      = "dd MMMM yyyy, HH:mm"
    static let     DATE_FORMAT_MM_SLASH_YY             = "MM/yy"
}

extension Date {
    
    func convertDateFormateToOrdinary() -> String{
        // Day
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: self)
        
        // Formate
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMMM, yyyy"
        let newDate = dateFormate.string(from: self)
        
        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + newDate
    }
    
    func addMonth(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .month, value: n, to: self)!
    }
    func addDay(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: n, to: self)!
    }
    func addSec(n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .second, value: n, to: self)!
    }
    
    func getCurrentDate() -> Date {
        
        let dateString = self.getStringFromDate(date: Date(), dateFormatter: DateFormats.DD_MMM_YYYY_FORMAT)
        let date = self.getDateFromString(dateString: dateString, dateFormatter: DateFormats.DD_MMM_YYYY_FORMAT)
        return date
    }
    
    func getCurrentTime() -> Date {
        
        let dateString = self.getStringFromDate(date: Date(), dateFormatter: DateFormats.FULL_DATE_FORMAT)
        let date = self.getDateFromString(dateString: dateString, dateFormatter: DateFormats.FULL_DATE_FORMAT)
        return date
    }
    
    func getDateFromString(dateString: String, dateFormatter: String) -> Date {
        
        let formatter = self.getDateFormatter(formatter: dateFormatter)
        return formatter.date(from: dateString)!
    }
    
    func getStringFromDate(date: Date, dateFormatter: String) -> String {
        
        let formatter = self.getDateFormatter(formatter: dateFormatter)
        return formatter.string(from: date)
    }
    
    func getStringFromDateString(dateString: String, dateFormatter: String) -> String {
        
        let date = self.getDateFromString(dateString: dateString, dateFormatter: DateFormats.DATE_FORMAT_DD_MM_YYYY)
        let mnthNumber = date.getMonthNumber()
        
        let dateStr = self.getStringFromDate(date: date, dateFormatter: dateFormatter)
        
        let nsRange = NSMakeRange(3,dateStr.characters.count - 3)
        let range = dateStr.index(dateStr.startIndex, offsetBy: nsRange.location)..<dateStr.index(dateStr.startIndex, offsetBy: nsRange.location + nsRange.length)
        
        let newStr = dateStr[range]
        
        let months = self.getMonthsIndex(index: mnthNumber - 1)
        return (months + newStr)
    }
    
    func getStringFromDateString(dateString: String, dateFormatter: String, stringDateFormatter: String) -> String {
        
        let date = self.getDateFromString(dateString: dateString, dateFormatter: stringDateFormatter)
        let mnthNumber = date.getMonthNumber()
        
        let fullDateStr = self.getStringFromDate(date: date, dateFormatter: dateFormatter)
        
        let dateStrRange = NSMakeRange(4,2)
        let rangeDate = fullDateStr.index(fullDateStr.startIndex, offsetBy: dateStrRange.location)..<fullDateStr.index(fullDateStr.startIndex, offsetBy: dateStrRange.location + dateStrRange.length)
        let dateStr = String(fullDateStr[rangeDate])
        
        let yearStrRange = NSMakeRange(8,4)
        let rangeYear = fullDateStr.index(fullDateStr.startIndex, offsetBy: yearStrRange.location)..<fullDateStr.index(fullDateStr.startIndex, offsetBy: yearStrRange.location + yearStrRange.length)
        let yearStr = String(fullDateStr[rangeYear])
        
        let mnth = self.getMonthsIndex(index: (mnthNumber - 1))
        return (dateStr + mnth + yearStr)
    }
    
    func getYearNumber() -> Int {
        
        var calender = Calendar.current
        calender.timeZone = TimeZone.init(abbreviation: TIME_ZONE)!
        return calender.component(.year, from: self)
    }
    
    func getMonthNumber() -> Int {
        
        var calender = Calendar.current
        calender.timeZone = TimeZone.init(abbreviation: TIME_ZONE)!
        return calender.component(.month, from: self)
    }
    
    func getDayNumner() -> Int {
        
        var calender = Calendar.current
        calender.timeZone = TimeZone.init(abbreviation: TIME_ZONE)!
        return calender.component(.day, from: self)
    }
    
    func getHour() -> Int {
        
        var calender = Calendar.current
        //calender.timeZone = TimeZone.init(abbreviation: TIME_ZONE)!
        return calender.component(.hour, from: self)
    }
    
    func getMinute() -> Int {
        
        var calender = Calendar.current
        calender.timeZone = TimeZone.init(abbreviation: TIME_ZONE)!
        return calender.component(.minute, from: self)
    }
    
    //MARK:- Private methods
    
    func getMonthsIndex(index: Int) -> String {
        
        let months = ["Jan","Feb","March","April","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"]
        
        return months[index]
    }
    
    func getDateFormatter(formatter: String) -> DateFormatter{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        dateFormatter.defaultDate = Date()
        let usLocale = Locale.init(identifier: "en_US")
        dateFormatter.locale = usLocale
        dateFormatter.timeZone = TimeZone.init(abbreviation: TIME_ZONE)
        return dateFormatter
    }
    
    static func checkForDate(dateString: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        dateFormatter.defaultDate = Date()
        let usLocale = Locale.init(identifier: "en_US")
        dateFormatter.locale = usLocale
        
        //"2017-11-06T15:40:25+05:30"
        let date1 =  dateFormatter.date(from:dateString)
        dateFormatter.dateFormat = "dd MMM yyyy, HH:mm:ss"
        let formattedDateString = dateFormatter.string(from: date1!)
        return formattedDateString
    }
    
    static func checkForTimeDiffrence(dateString: String) -> TimeInterval? {
        
        let dateString = "2017-11-21T13:39:21+08:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        dateFormatter.defaultDate = Date()
        let usLocale = Locale.init(identifier: "en_US")
        dateFormatter.locale = usLocale
        guard let date1 =  dateFormatter.date(from:dateString) else {
            
            return nil
        }
        let currentdate = Date()
        let terminationDuration = currentdate.timeIntervalSince(date1)
        return terminationDuration
    }
    
    static func checkForTimerDuration(dateString: String) -> DateComponents? {
        
        let dateString = "2017-11-21T13:39:21+08:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ" //TODO - Check for privious month
        dateFormatter.defaultDate = Date()
        let usLocale = Locale.init(identifier: "en_US")
        dateFormatter.locale = usLocale
        guard let date1 =  dateFormatter.date(from:dateString) else {
            return nil
        }
        let currentdate = Date()
        let dateComponents = Calendar.current.dateComponents([.minute, .second], from: currentdate, to: date1)
        return dateComponents
    }
    
    static func getDateString(dateString: String, fromDateFormatter : String, toDateFormatter: String) -> String {
        
        let date1 = Date().getDateFromString(dateString: dateString, dateFormatter: fromDateFormatter)
        let formattedDateString = date1.getStringFromDate(date: date1, dateFormatter: toDateFormatter)
        return formattedDateString
    }
    
    static func getSendDate(dateString: String)-> String{
        let date1 = Date().getDateFromString(dateString: dateString, dateFormatter: DateFormats.DATE_FORMAT_YYYY_MM_DD_HH_MM_SS)
        let formattedDateString = date1.getStringFromDate(date: date1, dateFormatter: DateFormats.DATE_FORMAT_DD_MMMM_YYYY_HH_MM)
        return formattedDateString
        
    }

}
