//
//  HttpsRequestManager.h
//  JianZuLianApp
//
//  Created by 张帅 on 2017/9/9.
//  Copyright © 2017年 JianZuLian. All rights reserved.
//

#import <Foundation/Foundation.h>

#define App_HttpsRequestManager [HttpsRequestManager shareHttpsRequestManager]

@interface HttpsRequestManager : NSObject

+ (HttpsRequestManager *)shareHttpsRequestManager;

/**  POST 请求 */
- (void)POST_HttpsRequestUrl:(NSString *)urlString andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**  终止 请求 */
- (void)stop_HttpsRequest;


/** 修改个人头像 上传头像 */
- (void)configPersonAvatarWithUrl:(NSString *)url imageData:(NSData *)imageData andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/** 发布回收 */
- (void)publishHuiShouWithUrl:(NSString *)url imageData:(NSData *)imageData andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/** 上传身份证  */
- (void)upLoadShenFenZhengWithurl:(NSString *)url card_face:(NSData *)card_face card_back:(NSData *)card_back andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/** 上传学生证  */
- (void)upLoadStudentInfoWithurl:(NSString *)url std_face:(NSData *)std_face andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;



















//--------------------------------------------------


/**  单张图片上传 请求 */
- (void)POST_OnePhoto_HttpsRequestUrl:(NSString *)urlString photo:(NSData *)photo andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
#pragma mark -单张图片上传 修改店铺图片
- (void)POST_OnePhoto_ConfigShopLogo_HttpsRequestUrl:(NSString *)urlString photo:(NSData *)photo andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark -单张图片上传 请求
- (void)test__POST_OnePhoto_HttpsRequestUrl:(NSString *)urlString imageDic:(NSArray *)imageDic andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


/**  多张图片上传 请求 */
- (void)POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString photos:(NSArray *)photos andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**  上传人才认证 头像 证书 请求 */
- (void)createTalent_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString avatar:(NSData *) avatar operation_certificate:(NSData *)operation_certificate andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**  发布招聘信息 上传公司图片（多张） */
- (void)publishPosition_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString image:(NSArray *)image andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**  实名认证（多张） */
- (void)sellerIdentification_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString frontimg:(NSData *)frontimg backimg:(NSData *)backimg andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**  发布维修单 上传多张照片 */
- (void)publishServiceOrder_POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString image:(NSArray *)image andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**  出租转让 请求 */
- (void)POST_MorePhoto_HttpsRequestUrl:(NSString *)urlString qualification:(NSString *)qualification qualificationArray:(NSArray *)qualificationArray recordcert:(NSString *)recordcert recordcertArray:(NSArray *)recordcertArray img:(NSString *)img imgArray:(NSArray *)imgArray andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


- (void)POST_User_HttpsRequestUrl:(NSString *)urlString photoName:(NSString *)photoName photo:(NSData *)photo andParameterDictionary:(id)parameters withSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
