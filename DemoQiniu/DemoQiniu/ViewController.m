//
//  ViewController.m
//  DemoQiniu
//
//  Created by Chris Hu on 16/9/27.
//  Copyright © 2016年 icetime17. All rights reserved.
//

#import "ViewController.h"
#import <Qiniu/QiniuSDK.h>
#import <Qiniu/QN_GTM_Base64.h>

#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()

@property (nonatomic, strong) NSString *accessKey;

@property (nonatomic, strong) NSString *secretKey;

@property (nonatomic, strong) NSString *scope;

@property (nonatomic, assign) NSInteger liveTime; // 天

@property (nonatomic, strong) NSString *qiniuToken;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accessKey = @"";
    self.secretKey = @"";
    self.scope = @"testqiniu";
    
    self.liveTime = 1;
    
    [self generateQiniuToken];
    
    [self testQiniu];
}

- (void)generateQiniuToken
{
    // http://www.tuicool.com/articles/BRriAnb
    NSMutableDictionary *authInfo = [NSMutableDictionary dictionary];
    [authInfo setObject:self.scope forKey:@"scope"];
    [authInfo setObject:[NSNumber numberWithLong:[[NSDate date] timeIntervalSince1970] + self.liveTime * 24 * 3600]
     forKey:@"deadline"];
    
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:authInfo options:NSJSONWritingPrettyPrinted error:nil];

    NSString *encodedString = [self urlSafeBase64Encode:jsonData];
    
    NSString *encodedSignedString = [self HMACSHA1:self.secretKey text:encodedString];
    
    self.qiniuToken =
    [NSString stringWithFormat:@"%@:%@:%@", self.accessKey, encodedSignedString, encodedString];
    
    NSLog(@"done");
}

- (NSString *)urlSafeBase64Encode:(NSData *)text {
    NSString *base64 =
    [[NSString alloc] initWithData:[QN_GTM_Base64 encodeData:text] encoding:NSUTF8StringEncoding];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64;
}

- (NSString *)HMACSHA1:(NSString *)key text:(NSString *)text {
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    
    char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash = [self urlSafeBase64Encode:HMAC];
    return hash;
}

- (void)testQiniu {
    NSString *token =  self.qiniuToken; // @"从服务端SDK获取"; 这里是客户端生成
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSString *key;
    NSData *data;
    
    
//    key = @"hello";
//    data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
    
    key = @"Model.jpg";
    data = UIImagePNGRepresentation([UIImage imageNamed:@"Model.jpg"]);
    
    [upManager putData:data key:key token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  NSLog(@"%@", info);
                  NSLog(@"%@", key);
                  NSLog(@"%@", resp);
              } option:nil];
    
    // 外链默认域名 http://xxxx + key即可
}

@end
