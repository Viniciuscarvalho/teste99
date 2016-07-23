//
//  LoginViewController.m
//  teste99
//
//  Created by Vinicius Carvalho on 23/07/16.
//  Copyright © 2016 Vinicius Carvalho. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.emailTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    self.passwordTextField.layer.borderColor = [[UIColor blackColor]CGColor];
    self.emailTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.borderWidth = 1.5;
    self.emailTextField.layer.cornerRadius = 20;
    self.passwordTextField.layer.cornerRadius = 20;
    
    self.loginButton.layer.cornerRadius = 20;
    
    [self textFieldShouldReturn:self.emailTextField];
    [self textFieldShouldReturn:self.passwordTextField];
    
    [self changePlaceholderTextToWhite];
    [self setupTapGestureRecognizer];
    [self dismissKeyboard];
    
}

- (IBAction)loginButtonTapped:(UIButton *)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([userPhoneNumber length] == 0 || [password length] == 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                 message:@"Make sure to enter your email and password correctly."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        // TODO PERSISTENCE AND SHOW MAPVIEW
        
    }

}

- (void)changePlaceholderTextToWhite {
    
    NSAttributedString *changeEmailToWhite = [[NSAttributedString alloc] initWithString:@"   Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    NSAttributedString *changePasswordToWhite = [[NSAttributedString alloc] initWithString:@"   Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    self.emailTextField.attributedPlaceholder = changeEmailToWhite;
    self.passwordTextField.attributedPlaceholder = changePasswordToWhite;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
    } else if (textField == self.emailTextField) {
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
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}



@end
