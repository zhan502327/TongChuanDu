//
//  HttpsRequestManager.m
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/9.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import "HttpsRequestManager.h"
#import "AFNetworking.h"

/** 超时时间 */
static int const DEFAULT_REQUEST_TIME_OUT = 15;

static HttpsRequestManager *shareHttpsRequestManager = nil;

@implementation HttpsRequestManager

+ (HttpsRequestManager *)shareHttpsRequestManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHttpsRequestManager = [[self alloc] init];
    });
    return shareHttpsRequestManager;
}

#pragma mark -POST 请求
- (void)POST_HttpsRequestUrl:(NSString *)urlString andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    

    
    [manager POST:urlString parameters:parameters progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

/**  终止 请求 */
- (void)stop_HttpsRequest {
    
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
}



/** 修改个人头像 上传头像 */
- (void)configPersonAvatarWithUrl:(NSString *)url imageData:(NSData *)imageData andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"value" fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


/** 发布回收 */
- (void)publishHuiShouWithUrl:(NSString *)url imageData:(NSData *)imageData andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"cover" fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

/** 上传身份证  */
- (void)upLoadShenFenZhengWithurl:(NSString *)url card_face:(NSData *)card_face card_back:(NSData *)card_back andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:card_face name:@"card_face" fileName:@"image.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:card_back name:@"card_back" fileName:@"image.png" mimeType:@"image/png"];

    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


/** 上传学生证  */
- (void)upLoadStudentInfoWithurl:(NSString *)url std_face:(NSData *)std_face andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:std_face name:@"std_face" fileName:@"image.png" mimeType:@"image/png"];
        
        
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    
    
}


















#pragma mark -单张图片上传 请求
- (void)POST_OnePhoto_HttpsRequestUrl:(NSString *)urlString photo:(NSData *)photo andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];

    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:photo name:@"avatar" fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

#pragma mark -单张图片上传 修改店铺图片
- (void)POST_OnePhoto_ConfigShopLogo_HttpsRequestUrl:(NSString *)urlString photo:(NSData *)photo andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:photo name:@"logo" fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

#pragma mark -单张图片上传 请求
- (void)test__POST_OnePhoto_HttpsRequestUrl:(NSString *)urlString imageDic:(NSArray *)imageDic andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageDic[0][1] name:imageDic[0][0] fileName:@"image.png" mimeType:@"image/png"];

        [formData appendPartWithFileData:imageDic[1][1] name:imageDic[1][0] fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

#pragma mark -多张图片上传 请求
- (void)POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString photos:(NSArray *)photos andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        for (int i = 0; i < photos.count; i++) {
            id imageObj = photos[i];
            NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image[%d]",i] fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/png"];
        }
    } progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

#pragma mark -上传/更新 人才认证 头像 证书
- (void)createTalent_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString avatar:(NSData *) avatar operation_certificate:(NSData *)operation_certificate andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:avatar name:@"avatar" fileName:@"image.png" mimeType:@"image/png"];
        
        [formData appendPartWithFileData:operation_certificate name:@"operation_certificate" fileName:@"image.png" mimeType:@"image/png"];

     
    } progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

#pragma mark - 发布招聘信息 上传公司图片（多张）
- (void)publishPosition_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString image:(NSArray *)image andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < image.count; i++) {
            id imageObj = image[i];
            NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image[%d]",i] fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/png"];
        }
    
        
    } progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}


#pragma mark - 实名认证
- (void)sellerIdentification_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString frontimg:(NSData *)frontimg backimg:(NSData *)backimg andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:frontimg name:@"frontimg" fileName:@"image.png" mimeType:@"image/png"];
        [formData appendPartWithFileData:backimg name:@"backimg" fileName:@"image.png" mimeType:@"image/png"];

        
        
    } progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}



#pragma mark - 发布维修单 上传多张照片
- (void)publishServiceOrder_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString image:(NSArray *)image andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < image.count; i++) {
            id imageObj = image[i];
            NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image[%d]",i] fileName:[NSString stringWithFormat:@"image%d.png",i] mimeType:@"image/png"];
        }
        
        
    } progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}



// 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)())success
                             failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - **************** 出租转让 请求
- (void)POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString qualification:(NSString *)qualification qualificationArray:(NSArray *)qualificationArray recordcert:(NSString *)recordcert recordcertArray:(NSArray *)recordcertArray img:(NSString *)img imgArray:(NSArray *)imgArray andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if ([qualification isEqualToString:@"qualification"]) {
            
            for (int i = 0; i < qualificationArray.count; i++) {
                id imageObj = qualificationArray[i];
                NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"qualification[%d]",i] fileName:[NSString stringWithFormat:@"qualification%d.png",i] mimeType:@"image/png"];
            }
        }
        if ([recordcert isEqualToString:@"recordcert"]) {
            for (int i = 0; i < recordcertArray.count; i++) {
                id imageObj = recordcertArray[i];
                NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"recordcert[%d]",i] fileName:[NSString stringWithFormat:@"recordcert%d.png",i] mimeType:@"image/png"];
            }
        }
        if ([img isEqualToString:@"img"]) {
            for (int i = 0; i < imgArray.count; i++) {
                id imageObj = imgArray[i];
                NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"img[%d]",i] fileName:[NSString stringWithFormat:@"img%d.png",i] mimeType:@"image/png"];
            }
        }
        
    } progress:^(NSProgress *uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (void)POST_User_HttpsRequestUrl:(NSString *)urlString photoName:(NSString *)photoName photo:(NSData *)photo andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure; {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:photo name:photoName fileName:@"image.png" mimeType:@"image/png"];
    } progress:^(NSProgress * uploadProgress) {
        // ------ 数据请求的进度
        // ******************
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}





@end
