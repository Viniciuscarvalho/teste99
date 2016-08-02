
#import <UIKit/UIKit.h>


@interface SignupViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate> {

    LLARingSpinnerView *spinnerView;

}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end
