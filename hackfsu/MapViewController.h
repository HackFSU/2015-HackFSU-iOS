//
//  MapViewController.h
//  hackfsu
//
//  Created by Logan Isitt on 3/21/14.
//  Copyright (c) 2014 Isitt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end
