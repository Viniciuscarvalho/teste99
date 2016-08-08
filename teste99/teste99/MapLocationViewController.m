

#import "MapLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "APIManager.h"
#import "DriverModel.h"
#import "RaceModel.h"

@interface MapLocationViewController() <MKMapViewDelegate>

@end

@implementation MapLocationViewController 

- (void) viewDidLoad {
    
    [super viewDidLoad];

    self.addressTextField.delegate = self;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
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

// MARK - Location Drivers

- (void) setLocationDrivers {
    
    __weak typeof(self) weakSelf = self;
    
    [APIManager locationDriver:(NSArray *)_sw pointNortheast:(NSArray *)_ne onSuccess:^(NSArray<DriverModel *> *locations){
        
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

- (void) selectDriver: (DriverModel *)driver {
    
    [self.mapView selectAnnotation:driver animated:YES];
    
}


// MARK - MKMapViewDelegate

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

// MARK - Request taxi

- (IBAction)requestTaxi:(id)sender {
    
    [APIManager requestTaxi: ^(id data) {
        
        if ( data != nil) {
            
            NSString *location = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            location = [location stringByReplacingOccurrencesOfString:@"http://ec2-54-88-12-34.compute-1.amazonaws.com/v1/ride/" withString:@""];
        
            [self getInformationsFromDriver: location];
        }
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"Try request Taxi again");
        
    }];

}

- (void) getInformationsFromDriver: (NSString *)location {

    int code = [location integerValue];
    
    [APIManager dataRacing:code onSuccess:^(id data) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSString *message = [json valueForKey:@"msg"];
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Solicitação do Táxi"
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    
    } onFailure:^(NSError *error) {
    
        NSLog(@"Try get information from driver");
        
    }];

}


// MARK - Location for user in textField

- (void)getAddressFromCurrentUser:(CLLocation *)currentLocation {

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
