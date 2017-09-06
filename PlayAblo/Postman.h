

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Constant.h"
@interface Postman : NSObject

// Get method
-(void)get:(NSString *)URLString withParameter:(NSString *)parameter success:(void(^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure;

// Post method
-(void)post:(NSString *)urlString withParameter:(NSString *)parameter success:(void(^)(AFHTTPRequestOperation *operation,id responseObject))success failure:(void(^)(AFHTTPRequestOperation *operation,NSError *error))failure;
@end
