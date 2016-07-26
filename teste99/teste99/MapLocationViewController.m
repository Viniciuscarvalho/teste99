

#import "MapLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@implementation MapLocationViewController 

- (void) viewDidLoad {
    
    [super viewDidLoad];

    self.searchTextField.delegate = self;
    self.mapView.delegate = self;

    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    [self setCurrentLocation];
    
}

// MARK - Location Delegate Methods

- (void) setCurrentLocation {
    
    if (self.locationManager == nil){
        self.locationManager = [[CLLocationManager alloc]init];
    }
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.005, 0.005);
    
    // set zoom to user's location
    self.location = self.locationManager.location;
    
    if (!self.hasUserLocation) {
        self.hasUserLocation = YES;
        [self.mapView setRegion:mapRegion animated:YES];
        // add the annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = userLocation.coordinate;
    }
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay {
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.tintColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
    return circleView;
}



@end
