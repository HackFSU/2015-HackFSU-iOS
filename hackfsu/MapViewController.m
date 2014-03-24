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
    }
    return self;
}

-(void)viewWillLayoutSubviews
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setMapType:MKMapTypeHybrid];
    [self.mapView setShowsBuildings:YES];
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 30.441372;
    zoomLocation.longitude= -84.294088;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, .1*METERS_PER_MILE, .1*METERS_PER_MILE);
    
    // 3
    [self.mapView setRegion:viewRegion animated:YES];
    
    NSString * address = @"Johnston Bldg";

    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 30.440795; //latitude.doubleValue;
    coordinate.longitude = -84.290129; //longitude.doubleValue;
    EventLocation *annotation = [[EventLocation alloc] initWithName:@"Hello" address:address coordinate:coordinate];

    [self.mapView addAnnotation:annotation];
    
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[EventLocation class]])
    {
        MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

@end