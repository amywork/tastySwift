//
//  Copyright (c) Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
@import GoogleSignIn;
@import Firebase;

// [START viewcontroller_interfaces]
@interface ViewController ()<FIRInviteDelegate, GIDSignInDelegate, GIDSignInUIDelegate>
// [END viewcontroller_interfaces]
// [START viewcontroller_vars]
@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@property(weak, nonatomic) IBOutlet UIButton *signOutButton;
@property(weak, nonatomic) IBOutlet UIButton *disconnectButton;
@property(weak, nonatomic) IBOutlet UIButton *inviteButton;
@property(weak, nonatomic) IBOutlet UILabel *statusText;
// [END viewcontroler_vars]
@end

@implementation ViewController

// [START viewdidload]
- (void)viewDidLoad {
  [super viewDidLoad];

  // TODO(developer) Configure the sign-in button look/feel
  [GIDSignIn sharedInstance].delegate = self;
  [GIDSignIn sharedInstance].uiDelegate = self;

  // Sign in automatically.
  [[GIDSignIn sharedInstance] signInSilently];

  [self setupUI];
  [self toggleAuthUI];
}
// [END viewdidload]

- (void)setupUI {
  float grayValue = (204.0 / 255);
  UIColor *grayColor = [UIColor colorWithRed:grayValue green:grayValue blue:grayValue alpha:1.0];

  _inviteButton.layer.cornerRadius = 3;
  _inviteButton.layer.shadowRadius = 1;
  _inviteButton.layer.shadowOffset = CGSizeMake(0, 0.5);
  _inviteButton.layer.shadowColor = [UIColor blackColor].CGColor;
  _inviteButton.layer.shadowOpacity = .7;

  _signOutButton.layer.borderWidth = .5;
  _signOutButton.layer.borderColor = grayColor.CGColor;
  _signOutButton.layer.cornerRadius = 2;
  _signOutButton.layer.shadowRadius = .5;
  _signOutButton.layer.shadowOffset = CGSizeMake(0, 0.5);
  _signOutButton.layer.shadowColor = [UIColor blackColor].CGColor;
  _signOutButton.layer.shadowOpacity = .4;

  _disconnectButton.layer.borderWidth = .5;
  _disconnectButton.layer.borderColor = grayColor.CGColor;
  _disconnectButton.layer.cornerRadius = 2;
  _disconnectButton.layer.shadowRadius = .5;
  _disconnectButton.layer.shadowOffset = CGSizeMake(0, 0.5);
  _disconnectButton.layer.shadowColor = [UIColor blackColor].CGColor;
  _disconnectButton.layer.shadowOpacity = .4;
}

// [START signin_handler]
- (void)signIn:(GIDSignIn *)signIn
    didSignInForUser:(GIDGoogleUser *)user
           withError:(NSError *)error {
  // Perform any operations on signed in user here.
  if (user.profile.name) {
    _statusText.text = [NSString stringWithFormat:@"Signed in as %@", user.profile.name];
  } else {
    _statusText.text = @"Signed in, profile name is not set";
  }
  [self toggleAuthUI];
}
// [END signin_handler]

// [START disconnect_handler]
- (void)signIn:(GIDSignIn *)signIn
    didDisconnectWithUser:(GIDGoogleUser *)user
                withError:(NSError *)error {
  // Perform any operations when the user disconnects from app here.
  _statusText.text = @"Disconnected user";
  [self toggleAuthUI];
}
// [END disconnect_handler]

// [START signout_tapped]
- (IBAction)signOutTapped:(id)sender {
  [[GIDSignIn sharedInstance] signOut];
  _statusText.text = @"Signed out";
  [self toggleAuthUI];
}
// [END signout_tapped]

// [START disconnect_tapped]
- (IBAction)disconnectTapped:(id)sender {
  [[GIDSignIn sharedInstance] disconnect];
}
// [END disconnect_tapped]

// [START invite_tapped]
- (IBAction)inviteTapped:(id)sender {
  id<FIRInviteBuilder> inviteDialog = [FIRInvites inviteDialog];
  [inviteDialog setInviteDelegate:self];

  // NOTE: You must have the App Store ID set in your developer console project
  // in order for invitations to successfully be sent.
  NSString *message =
      [NSString stringWithFormat:@"Try this out!\n -%@",
                                 [GIDSignIn sharedInstance].currentUser.profile.name];

  // A message hint for the dialog. Note this manifests differently depending on the
  // received invitation type. For example, in an email invite this appears as the subject.
  [inviteDialog setMessage:message];

  // Title for the dialog, this is what the user sees before sending the invites.
  [inviteDialog setTitle:@"Invites Example"];
  [inviteDialog setDeepLink:@"app_url"];
  [inviteDialog setCallToActionText:@"Install!"];
  [inviteDialog setCustomImage:@"https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"];
  [inviteDialog open];
}
// [END invite_tapped]

// [START invite_finished]
- (void)inviteFinishedWithInvitations:(NSArray *)invitationIds error:(NSError *)error {
  if (error) {
    NSLog(@"%@", error.localizedDescription);
  } else {
    NSLog(@"%li invites sent", invitationIds.count);
  }
}
// [END invite_finished]

// [START toggle_auth]
- (void)toggleAuthUI {
  if ([GIDSignIn sharedInstance].currentUser.authentication == nil) {
    // Not signed in
    _signInButton.enabled = YES;
    _signOutButton.enabled = NO;
    _disconnectButton.enabled = NO;
    _inviteButton.enabled = NO;
    [self performSegueWithIdentifier:@"SignedOutScreen" sender:self];
  } else {
    // Signed in
    _signInButton.enabled = NO;
    _signOutButton.enabled = YES;
    _disconnectButton.enabled = YES;
    _inviteButton.enabled = YES;
  }
}
// [END toggle_auth]

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}
@end
