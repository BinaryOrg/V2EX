//
//  ShowAPIRequest.h
//  V2EX
//
//  Created by Maker on 2019/2/14.
//  Copyright © 2019 binary. All rights reserved.
//




#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface ShowAPIRequest : NSObject{
    NSString *showapi_appid;
    NSString *showapi_sign;
    
    
}
-(id)initWithAppid:(NSString*)appid andSign:(NSString*)sign;

-(void)post:(NSString*)url timeout:(int)timeout params:(NSDictionary<NSString*,NSString*>*) params fileParams:(NSDictionary<NSString*,NSData*>*) fileParams withCompletion:(void (^)(NSDictionary<NSString*,id>*))completion;
-(void)post:(NSString*)url timeout:(int)timeout params:(NSDictionary<NSString*,NSString*>*) params  withCompletion:(void (^)(NSDictionary<NSString*,id>*))completion;

@end

NS_ASSUME_NONNULL_END
