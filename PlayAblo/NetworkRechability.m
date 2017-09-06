
#import "NetworkRechability.h"
#import "Reachability.h"
@implementation NetworkRechability

//Network is cheacking method


- (BOOL)checkRechability
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
        
        self.isNetwork=NO;
        
        
    } else
    {
        NSLog(@"There IS internet connection");
        
        self.isNetwork=YES;
        
    }
    
    return self.isNetwork;

}


@end


