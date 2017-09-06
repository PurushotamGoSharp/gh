

#import "Postman.h"
#import <AFNetworking/AFNetworking.h>
@implementation Postman
{
  AFHTTPRequestOperationManager *manager;
  AFJSONRequestSerializer *requestSerializer;
}
-(id)init
{
    if (self = [super init])
    {
        [self initiate];
    }
    
    return self;
}

-(void)initiate
{
    manager = [AFHTTPRequestOperationManager manager];
    requestSerializer = [AFJSONRequestSerializer serializer];
    [self setheadermethod];
    
}
-(void)setheadermethod
{
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [requestSerializer setValue:@"10034" forHTTPHeaderField:@"x-User"];
//    [requestSerializer setValue:@"2AP7S5" forHTTPHeaderField:@"x-AppType"];
//    [requestSerializer setValue:@"KP18Z7" forHTTPHeaderField:@"x-ApplicableVersion"];
//    [requestSerializer setValue:@"SR67TUL47EK" forHTTPHeaderField:@"x-Trans-token"];
    manager.requestSerializer = requestSerializer;
    
}

// Get method implementation
-(void)get:(NSString *)URLString withParameter:(NSString *)parameter success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id  responseObject)
     {
         success(operation,responseObject);
     } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error)
     {
         failure(operation,error);
     }];
}

// Post method implementation
-(void)post:(NSString *)urlString withParameter:(NSString *)parameter success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSDictionary *parameterDict=[NSJSONSerialization JSONObjectWithData:[parameter dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    
    [manager POST:urlString parameters:parameterDict success:^(AFHTTPRequestOperation * operation, id  responseObject)
     {
         success(operation,responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation,error);
     }];
}

@end
