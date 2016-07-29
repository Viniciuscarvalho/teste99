

#import "MapLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "APIManager.h"
#import "DriverModel.h"

@implementation MapLocationViewController 

- (void) viewDidLoad {
    
    [super viewDidLoad];

    self.addressTextField.delegate = self;
    self.mapView = [[MKMapView alloc] init];
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


// MARK - Location of drivers

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
    
        return nil;
        
    }
    
    static NSString *annotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinAnnotation) {
    
        pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    
    } else {
    
        pinAnnotation.annotation = annotation;
        
    }
    
    pinAnnotation.pinTintColor = MKPinAnnotationColorRed;
    pinAnnotation.animatesDrop = YES;
    
    return pinAnnotation;

};

- (void) setLocationDrivers {
    
    [APIManager locationDriver:(NSArray *)_sw pointNortheast:(NSArray *)_ne onSuccess:^(NSArray<DriverModel *> *locations){
        __weak typeof(self) weakSelf = self;
        
        for (DriverModel *driver in locations) {
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(driver.latitude, driver.longitude);
            MKPointAnnotation *annotation= [MKPointAnnotation new];
            annotation.coordinate= coordinate;
            [weakSelf.mapView addAnnotation: annotation];
        }
    
    } onFailure:^(NSError *error) {
        
        NSLog(@"Error in load points");
    
    }];
    
}

// MARK - Location for user in textField

- (void) getAddressFromCurrentUser:(CLLocation *)currentLocation {

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
    
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
    }];

}





@end
