

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapLocationViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTextField;
@property (nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic) BOOL hasUserLocation;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


@end
