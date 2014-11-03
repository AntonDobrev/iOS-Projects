
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "ViewController.h"
#import <EverliveSDK/EverliveSDK.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (IBAction)register:(id)sender {
    
    [Everlive setApplicationKey:@"E8tMoGEClJf0xmvV"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"PushSample",@"appName", nil];
    [[Everlive sharedInstance]registerDeviceWithParameters:dictionary block:^(BOOL success, NSError *error) {
        if(error != Nil){
            [self.infoLabel setText:error.localizedDescription];
        }
        else{
            [self.infoLabel setText:@"Your device is now registered and ready to recieve push notifications."];
        }
    }];
}
- (IBAction)unregister:(id)sender {
    
    [[Everlive sharedInstance]removeDevice:^(BOOL success, NSError *error) {
        if(error != Nil){
            [self.infoLabel setText:error.localizedDescription];
        }
        else{
            [self.infoLabel setText:@"You have unregistered your device."];
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
