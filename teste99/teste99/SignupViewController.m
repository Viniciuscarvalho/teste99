
#import <Realm/Realm.h>

#import "SignupViewController.h"
#import "UserModel.h"

@implementation SignupViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self configureTextFields];
    
    [self changePlaceholderTextToWhite];
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
        
        // TODO POST FROM JSON FOR CREATE USER
        
        if (!error) {
        
            UIViewController *mapLocation = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"mapLocationViewControllerIdentifier"];
        
            [self presentViewController:mapLocation animated:YES completion:nil];
                
            [defaults synchronize];
        } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                                         message:[error.userInfo objectForKey:@"error"]
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:ok];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

- (void) changePlaceholderTextToWhite {
    
    NSAttributedString *changeUsernameToWhite = [[NSAttributedString alloc] initWithString:@"   First Name" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *changePhoneNumberToWhite = [[NSAttributedString alloc] initWithString:@"   Phone Number" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *changePasswordToWhite = [[NSAttributedString alloc] initWithString:@"   Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    self.usernameTextField.attributedPlaceholder = changeUsernameToWhite;
    self.phoneNumberTextField.attributedPlaceholder = changePhoneNumberToWhite;
    self.passwordTextField.attributedPlaceholder = changePasswordToWhite;
    
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
