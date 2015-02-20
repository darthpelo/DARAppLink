# DARAppLink
Simple iOS application to show how open another application or to download this application from iTunes

## Check if the application is installed on the device
`BOOL canOpenURL = [[UIApplication sharedApplication]
                       canOpenURL:[NSURL URLWithString:@"eatizer://"]];
    if (canOpenURL) [[UIApplication sharedApplication]
                       openURL:[NSURL URLWithString:@"eatizer://"]];`
