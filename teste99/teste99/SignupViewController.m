
#import "SignupViewController.h"
#import "UserModel.h"
#import "APIManager.h"
#import <LLARingSpinnerView/LLARingSpinnerView.h>


@implementation SignupViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:true];
    
    [self configureTextFields];
    
    [self changePlaceholderTextToGray];
    [self setupTapGestureRecognizer];
    [self dismissKeyboard];
}

- (void) configureTextFields {

    self.usernameTextField.delegate = self;
    self.usernameTextField.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.usernameTextField.layer.borderWidth = 1.5;
    self.usernameTextField.layer.cornerRadius = 20;
    
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.phoneNumberTextField.layer.borderWidth = 1.5;
    self.phoneNumberTextField.layer.cornerRadius = 20;
    
    self.passwordTextField.delegate = self;
    self.passwordTextField.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.cornerRadius = 20;
    
    self.signUpButton.layer.cornerRadius = 20;
    
    [self textFieldShouldReturn:self.usernameTextField];
    [self textFieldShouldReturn:self.phoneNumberTextField];
    [self textFieldShouldReturn:self.passwordTextField];
    
}

- (void)showLoadingSpinner {
    
    [self.view addSubview:spinnerView];
    [spinnerView startAnimating];
}

- (void)hideLoadingSpinner {
    
    [spinnerView stopAnimating];
    [spinnerView removeFromSuperview];
}

- (IBAction) signupButtonTapped:(UIButton *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *userPhoneNumber = [self.phoneNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *userPassword = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length] == 0 || [userPassword length] == 0 || [userPhoneNumber length] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                 message:@"Make sure to enter your first name, phone number, and password!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        
        [self showLoadingSpinner];
        
        [APIManager signupUser:username onSuccess:^(id data)  {
            
            // Pass Dictionary with userData
            [APIManager saveUserData: nil];
            
            UIViewController *mapLocation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mapLocationViewControllerIdentifier"];
            
            [self presentViewController:mapLocation animated:YES completion:nil];
            
            [defaults synchronize];
        
        } onFailure:^(NSError *error) {
        
            [self hideLoadingSpinner];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                                     message:[error.userInfo objectForKey:@"error"]
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];

            NSLog(@"erro");
            
        }];
    }
}


- (void) changePlaceholderTextToGray {
    
    NSAttributedString *changeUsernameToGray = [[NSAttributedString alloc] initWithString:@"   First Name" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    NSAttributedString *changePhoneNumberToGray = [[NSAttributedString alloc] initWithString:@"   Phone Number" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    NSAttributedString *changePasswordToGray = [[NSAttributedString alloc] initWithString:@"   Password" attributes:@{ NSForegroundColorAttributeName : [UIColor grayColor] }];
    
    self.usernameTextField.attributedPlaceholder = changeUsernameToGray;
    self.phoneNumberTextField.attributedPlaceholder = changePhoneNumberToGray;
    self.passwordTextField.attributedPlaceholder = changePasswordToGray;
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
    } else if (textField == self.usernameTextField) {
        [self.phoneNumberTextField becomeFirstResponder];
    }
    return YES;
}

- (void) setupTapGestureRecognizer {
    // tap to dismiss keyboard!
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:YES];
}

-(void) dismissKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


@end
