//
//  EventLocation.m
//  hackfsu
//
//  Created by Logan Isitt on 3/23/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "EventLocation.h"
#import <AddressBook/AddressBook.h>

@implementation EventLocation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self = [super init]))
    {
        if ([name isKindOfClass:[NSString class]])
        {
            self.name = name;
        }
        else
        {
            self.name = @"Unknown charge";
        }
        self.address = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title
{
    return _name;
}

- (NSString *)subtitle
{
    return _address;
}

- (CLLocationCoordinate2D)coordinate
{
    return _theCoordinate;
}

- (MKMapItem*)mapItem
{
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end