

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapManager : NSObject <MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

@property (nonatomic) MKMapView *mapView;
@property (nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic) BOOL hasUserLocation;

@property (nonatomic) id geofence;
@property (nonatomic) MKCircle *overlay;
@property (nonatomic) NSMutableSet *insideGeofenceIds;

@end
