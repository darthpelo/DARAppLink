# DARAppLink
Simple iOS application to show how open another application or to download this application from iTunes. This example is based on [elpsk](https://github.com/elpsk/) posts :-)

### How To
Check if the application is installed on the device ([link](http://stackoverflow.com/a/13009069/3419402))
```objectivec
BOOL canOpenURL = [[UIApplication sharedApplication]
                       canOpenURL:[NSURL URLWithString:@"eatizer://"]];
    if (canOpenURL) [[UIApplication sharedApplication]
                       openURL:[NSURL URLWithString:@"eatizer://"]];
```
If the check fails, open the iTunes page related to the application. 
To do this you can user **StoreKit** (only + iOS6) [original link](http://www.albertopasca.it/whiletrue/2013/06/objectivec-in-app-download/)
```objectivec
- (void)presentInAppStoreForID:(NSString *)appStoreID
                     withDelegate:(id < SKStoreProductViewControllerDelegate >)delegate
                   andOptionalURL:(NSURL *)appStoreURL
{
    // check for iOS6 available class
    if (NSClassFromString(@"SKStoreProductViewController")) {
        SKStoreProductViewController *storeController = [[SKStoreProductViewController alloc] init];
        storeController.delegate = delegate;
        
        NSDictionary *productParameters = @{ SKStoreProductParameterITunesItemIdentifier : appStoreID };
        [storeController loadProductWithParameters:productParameters 
                                   completionBlock:^( BOOL result, NSError *error ) {
             if (result) {
                 [ self presentViewController:storeController animated:YES completion:nil ];
             }
         }];
    } else {
        [[ UIApplication sharedApplication ] openURL: appStoreURL ];
    }
}
````
Remember to [create](http://stackoverflow.com/questions/13004357/app-cant-be-installed-with-skstoreproductviewcontroller) a StoreKit Test user ;-) 
## Acknowledgements
Alberto Pasca [elpsk](https://github.com/elpsk/)
