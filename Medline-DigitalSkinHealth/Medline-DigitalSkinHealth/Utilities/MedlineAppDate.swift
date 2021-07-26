//
//  MedlineAppDate.swift
//  Medline-DigitalSkinHealth
//
//  Created by Sunil Kumar Jaiswal on 20/02/21.
//

import Foundation
import UIKit

class MedlineAppDate {
    
    public static let appDateFormatOne:String = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    public static let appDateFormatTwo:String = "yyyy-MM-dd HH:mm:ss"
    public static let appDateFormatThree:String = "yyyy-MM-dd HH:mm:ss.s"
    public static let appDateFormatFour:String = "yyyy-MM-dd HH:mm:ss.SSS"
    public static let appDateFormatFive:String = "dd MMM yyyy hh:mm a"
    public static let appDateFormatSix:String = "dd MMM yyyy 'at' hh:mm a"
    public static let appDateFormatSeven:String = "MM-dd-yyyy HH:mm"
    public static let appDateFormatEight:String = "dd MMM yyyy"
    public static let appDateFormatNine:String = "dd MMMM yyyy"
    public static let appDateFormatTen:String = "dd MMM yy"
    public static let appDateFormatEleven:String = "yyyy-MM-dd"
    public static let appDateFormatTwelve:String = "MM-dd-yyyy"
    public static let appDateFormatThirteen:String = "dd/MM/yyyy"
    public static let appDateFormatFourteen:String = "DD/MM/YYYY"
    public static let appDateFormatFifteen:String = "MMMM yyyy"
    public static let appDateFormatSixteen:String = "dd MMM"
    public static let appDateFormatSeventeen:String = "HH:mm a"
    public static let appDateFormatEighteen:String = "HH:mm"
    
    open class func retrieveCurrentDate(outputDateformat:String?) -> String {
        var resultDate:String? = ""
        if outputDateformat != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = retrieveProperString(retrieveString: outputDateformat)
            dateFormatter.timeZone = NSTimeZone.local
            resultDate = dateFormatter.string(from: Date())
        }
        return resultDate ?? ""
    }
    
    open class func retrieveCurrentDateInTimestamp() throws ->String {
        var dateInTimestamp:String? = ""
        let timeInterval:UInt64 = UInt64((Date().timeIntervalSince1970) * 1000)
        dateInTimestamp = String(timeInterval)
        return dateInTimestamp ?? ""
    }
    
    open class func convertTimestampToDate(inputTimeStamp:Int64, outDateFormat:String?) throws ->String {
        var returnConvertedDate:String? = ""
        if inputTimeStamp > 0 && retrieveProperString(retrieveString: outDateFormat) != "" {
            
            let dateTimeStamp = Date(timeIntervalSince1970:Double(inputTimeStamp)/1000)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.local
            dateFormatter.dateFormat = retrieveProperString(retrieveString: outDateFormat)
            
            returnConvertedDate = dateFormatter.string(from: dateTimeStamp as Date)
        }
        return returnConvertedDate ?? ""
    }
    
    open class func changeStringDateFormat(inputDateString:String?, inDateFormat:String?, outDateFormat:String?) throws ->String {
        var convertedDateInString:String? = ""
        if retrieveProperString(retrieveString: inputDateString) != "" && retrieveProperString(retrieveString: inDateFormat) != "" && retrieveProperString(retrieveString: outDateFormat) != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = retrieveProperString(retrieveString: inDateFormat)
            dateFormatter.timeZone = NSTimeZone.local
            
            if retrieveProperString(retrieveString: inputDateString) != "" {
                do{
                    let date:Date = try convertStringToDate(inputDateString: retrieveProperString(retrieveString: inputDateString), inDateFormat: retrieveProperString(retrieveString: inDateFormat))
                    dateFormatter.dateFormat = retrieveProperString(retrieveString: outDateFormat)
                    dateFormatter.timeZone = NSTimeZone.local
                    convertedDateInString = dateFormatter.string(from: date)
                }catch{
                    
                }
            }
        }
        return convertedDateInString ?? ""
    }
    
    open class func convertStringToDate(inputDateString:String?, inDateFormat:String?) throws ->Date {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = retrieveProperString(retrieveString: inDateFormat)
        dateFormatter.timeZone = NSTimeZone.local
        
        if retrieveProperString(retrieveString: inputDateString) != "" {
            if let retrieveDate:Date = dateFormatter.date(from: retrieveProperString(retrieveString: inputDateString)) {
                date = retrieveDate
            }else{
                date = Date()
                date = dateFormatter.date(from: retrieveProperString(retrieveString: dateFormatter.string(from: date)))!
            }
        }else{
            date = Date()
            date = dateFormatter.date(from: retrieveProperString(retrieveString: dateFormatter.string(from: date)))!
        }
        return date
    }
    
    open class func currentDateInTimestamp() -> Int64 {
        return Int64((Date().timeIntervalSince1970) * 1000)
    }
    
    open class func convertDateInMiliseconds(retrieveDate:Date?) -> Int64 {
        var convertedDateInMillisecond:Int64 = 0
        if retrieveDate != nil {
            if let since1970 = retrieveDate?.timeIntervalSince1970 {
                convertedDateInMillisecond = Int64(since1970 * 1000)
            }
        }
        return convertedDateInMillisecond
    }
    
    open class func addMinuteInCurrentDate(addMinute:Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: addMinute, to: Date()) ?? Date()
    }
}
