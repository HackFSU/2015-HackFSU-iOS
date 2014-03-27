//
//  MapViewController.m
//  hackfsu
//
//  Created by Logan Isitt on 3/21/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import "MapViewController.h"
#import "EventLocation.h"

#define METERS_PER_MILE 1609.344

@implementation MapViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.title = @"Map";
        self.screenName = self.title;
        
        PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
        [query orderByDescending:@"updatedAt"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             if (!error)
                 self.mapLocations = objects;
             else
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
         }];
    }
    return self;
}

-(void)viewWillLayoutSubviews
{
    if (!self.mapView)
    {
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        [self.mapView setMapType:MKMapTypeHybrid];
        [self.mapView setShowsBuildings:YES];
        
        [self.view addSubview:self.mapView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
             self.mapLocations = objects;
         else
             NSLog(@"Error: %@ %@", error, [error userInfo]);
     }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.mapView)
    {
        self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        [self.mapView setDelegate:self];
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        [self.mapView setMapType:MKMapTypeHybrid];
        [self.mapView setShowsBuildings:YES];
        
        [self.view addSubview:self.mapView];
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
             self.mapLocations = objects;
         else
             NSLog(@"Error: %@ %@", error, [error userInfo]);
     }];
    
    while (!self.mapView)
    {
        //
    }
    
    for (PFObject *p in self.mapLocations)
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude     = [[p valueForKey:@"latitude"] floatValue]; //latitude.doubleValue;
        coordinate.longitude    = [[p valueForKey:@"longitude"] floatValue]; //latitude.doubleValue;
        
        EventLocation *annotation = [[EventLocation alloc] initWithName:[p valueForKey:@"title"] address:[p valueForKey:@"des"] coordinate:coordinate];
        
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:YES];
    }
    
    if ([self.mapLocations count] == 0) return;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [[[self.mapLocations firstObject] valueForKey:@"latitude"] floatValue];
    zoomLocation.longitude= [[[self.mapLocations firstObject] valueForKey:@"longitude"] floatValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, .1*METERS_PER_MILE, .1*METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
    
//    [self.mapView selectAnnotation:[self.mapView.annotations firstObject] animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                   reuseIdentifier:@"Annotation"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annView.enabled = YES;
    annView.canShowCallout = YES;
    
    return annView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    EventLocation *location = (EventLocation*)view.annotation;
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [location.mapItem openInMapsWithLaunchOptions:launchOptions];
}

@end