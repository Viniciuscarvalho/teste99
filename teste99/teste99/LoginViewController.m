
#import "LoginViewController.h"

@interface LoginViewController()

@end

@implementation LoginViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.usernameTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    self.passwordTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    self.usernameTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.borderWidth = 1.5;
    self.usernameTextField.layer.cornerRadius = 20;
    self.passwordTextField.layer.cornerRadius = 20;
    
    self.loginButton.layer.cornerRadius = 20;
    
    [self textFieldShouldReturn:self.usernameTextField];
    [self textFieldShouldReturn:self.passwordTextField];
    
    [self changePlaceholderTextToWhite];
    [self setupTapGestureRecognizer];
    [self dismissKeyboard];
    
}

- (IBAction)loginButtonTapped:(UIButton *)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                 message:@"Make sure to enter your email and password correctly."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        
        
    }

}

- (void)changePlaceholderTextToWhite {
    
    NSAttributedString *changeEmailToWhite = [[NSAttributedString alloc] initWithString:@"   Username" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *changePasswordToWhite = [[NSAttributedString alloc] initWithString:@"   Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    self.usernameTextField.attributedPlaceholder = changeEmailToWhite;
    self.passwordTextField.attributedPlaceholder = changePasswordToWhite;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
    } else if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    return YES;
}

- (void)setupTapGestureRecognizer {
    // tap to dismiss keyboard!
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:YES];
}

-(void)dismissKeyboard {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}



@end
