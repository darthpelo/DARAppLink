//
//  ViewController.m
//  DARAppLinkTest
//
//  Created by Alessio Roberto on 20/02/15.
//  Copyright (c) 2015 Alessio Roberto. All rights reserved.
//

#import "ViewController.h"

@import StoreKit;

@interface ViewController () <SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openLink:(id)sender {
    [self openAnotherApplication];
}

- ( void ) presentInAppStoreForID: ( NSString * ) appStoreID
                     withDelegate: ( id < SKStoreProductViewControllerDelegate > ) delegate
                   andOptionalURL: ( NSURL * ) appStoreURL
{
    // check for iOS6 available class
    if (NSClassFromString(@"SKStoreProductViewController")) {
        SKStoreProductViewController *storeController = [[SKStoreProductViewController alloc] init];
        storeController.delegate = delegate;
        
        NSDictionary *productParameters = @{ SKStoreProductParameterITunesItemIdentifier : appStoreID };
        [storeController loadProductWithParameters: productParameters completionBlock:^( BOOL result, NSError *error ) {
             if (result) {
                 [ self presentViewController:storeController animated:YES completion:nil ];
             }
         }];
    } else {
        [[ UIApplication sharedApplication ] openURL: appStoreURL ];
    }
}

- (void)openAnotherApplication
{
    BOOL canOpenURL = [[UIApplication sharedApplication]
                       canOpenURL:[NSURL URLWithString:@"eatizer://"]];
    if (canOpenURL) [[UIApplication sharedApplication]
                       openURL:[NSURL URLWithString:@"eatizer://"]];
    else
        [self presentInAppStoreForID:@"961615773"
                        withDelegate:self
                      andOptionalURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/it/app/eatizer/id961615773"]];
}
#pragma mark - StoreKit delegate

- ( void ) productViewControllerDidFinish: ( SKStoreProductViewController * ) viewController
{
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

@end
