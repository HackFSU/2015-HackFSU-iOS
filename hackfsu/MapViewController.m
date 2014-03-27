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
        
        PFQuery *query = [PFQuery queryWithClassName:@"Locations"];
        
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
        [self.mapView setMapType:MKMapTypeStandard];
        [self.mapView setShowsBuildings:YES];
        
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = 30.441372;
        zoomLocation.longitude= -84.294088;
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, .1*METERS_PER_MILE, .1*METERS_PER_MILE);
        
        [self.mapView setRegion:viewRegion animated:YES];
        
        [self.view addSubview:self.mapView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 30.440795; //latitude.doubleValue;
    coordinate.longitude = -84.290129; //longitude.doubleValue;
    
    for (PFObject *p in self.mapLocations)
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude     = [[p valueForKey:@"latitude"] floatValue]; //latitude.doubleValue;
        coordinate.longitude    = [[p valueForKey:@"longitude"] floatValue]; //latitude.doubleValue;
        
        EventLocation *annotation = [[EventLocation alloc] initWithName:[p valueForKey:@"title"] address:[p valueForKey:@"des"] coordinate:coordinate];
        
        [self.mapView addAnnotation:annotation];
    }
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