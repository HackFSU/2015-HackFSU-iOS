//
//  NSDateExtension.swift
//  HackFSU
//
//  Created by Logan Isitt on 3/8/15.
//  Copyright (c) 2015 Logan Isitt. All rights reserved.
//

import UIKit

extension NSDate {
    
    func dateWithoutTime() -> NSDate? {
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var comps = calendar?.components(NSCalendarUnit.YearCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.CalendarUnitTimeZone, fromDate: self)
        comps?.timeZone = NSTimeZone.localTimeZone()
        return calendar?.dateFromComponents(comps!)
    }
}
