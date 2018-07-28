//
//  BXGNetwork.h
//  BoxueguHD
//
//  Created by Renying Wu on 2018/7/5.
//  Copyright © 2018年 boxuegu. All rights reserved.
//

#ifndef BXGNetwork_h
#define BXGNetwork_h

#define BXG_NETWORK_ENV_DEVELOPMENT                                 @"http://portal-api-d1.boxuegu.com/"            // 研发 App服务
#define BXG_NETWORK_ENV_DEVELOPMENT_USER_CENTER                     @"http://online-dev.boxuegu.com/"               // 研发 User服务
#define BXG_NETWORK_ENV_DEVELOPMENT_QALIB_CENTER                    @"http://qalib-center-d.boxuegu.com/"           // 研发 问答精灵服务
#define BXG_NETWORK_ENV_DEVELOPMENT_QALIB_API                       @"http://qalib-api-d.boxuegu.com/"              // 研发 问答库服务
#define BXG_NETWORK_ENV_DEVELOPMENT_CONSULT                         @"http://consult-d.boxuegu.com/"                // 研发 咨询服务(内网)
#define BXG_NETWORK_ENV_TEST_API_IP_01                              @"http://211.103.142.26:5881/"                  // 测试 AppIP服务(外网 Test1)
#define BXG_NETWORK_ENV_TEST_API_01                                 @"http://proxy.boxuegu.com/portal-api-test/"    // 测试 App服务(外网 Test1)
#define BXG_NETWORK_ENV_TEST_API_02                                 @"http://proxy.boxuegu.com/portal-api-test1/"   // 测试 App服务(外网 Test2)
#define BXG_NETWORK_ENV_TEST_API_LOCAL_02                           @"http://portal-api-t1.boxuegu.com/"            // 测试 h5服务(内网 Test2)
#define BXG_NETWORK_ENV_TEST_CONSULT                                @"http://consult-t.boxuegu.com/"                // 测试 咨询服务(内网)
#define BXG_NETWORK_ENV_TEST_QALIB_CENTER                           @"http://qalib-center-t.boxuegu.com/"           // 测试 问答精灵服务(内网)
#define BXG_NETWORK_ENV_TEST_QALIB_API                              @"http://qalib-api-t.boxuegu.com/"              // 测试 问答库服务(内网)
#define BXG_NETWORK_ENV_PRE_PRODUCT                                 @"http://api-ysc.bxg.boxuegu.com/"              // 预生产 App服务
#define BXG_NETWORK_ENV_PRE_PREDUCT_QALIB_CENTER                    @"http://ask-center-ysc.bxg.boxuegu.com/"        // 预生产 问答精灵服务
#define BXG_NETWORK_ENV_PRE_PREDUCT_QALIB_API                       @"http://ask-api-ysc.bxg.boxuegu.com/"           // 预生产 问答库服务
#define BXG_NETWORK_ENV_RELEASE                                     @"https://app.boxuegu.com/"                     // 正式 App服务
#define BXG_NETWORK_ENV_RELEASE_CONSULT                             @"https://app.boxuegu.com/consult/"             // 正式 咨询服务
//#define BXG_NETWORK_ENV_RELEASE_QALIB_CENTER                        @"https://ask-center.boxuegu.com/"               // 正式 问答精灵服务
#define BXG_NETWORK_ENV_RELEASE_QALIB_CENTER                        @"https://qa.boxuegu.com/"               // 正式 问答精灵服务
#define BXG_NETWORK_ENV_RELEASE_QALIB_API                           @"https://qa.boxuegu.com/api/"                   // 正式 问答库服务

#define BXG_NETWORK_ENV_PRE_PRODUCT_LOCAL                           @"http://172.16.1.35:8258/"                     // 预生产 App服务(内网)
#define BXG_NETWORK_ENV_TEST_LOCAL_01                               @"http://online-test.boxuegu.com/"              // 测试 App服务(内网 Test1) 感觉已废弃
#define BXG_NETWORK_ENV_TEST_LOCAL_02                               @"http://online-test2.boxuegu.com/"             // 测试 App服务(内网 Test2) 感觉已废弃
#define BXG_NETWORK_ENV_DEVELOPMENT_QALIB_CENTER_DEPRECATED         @"http://portal-api-d1.boxuegu.com/ask-d/"      // 研发 问答精灵服务(过期)
#define BXG_NETWORK_ENV_DEVELOPMENT_QALIB_API_DEPRECATED            @"http://portal-api-d1.boxuegu.com/ask-api-d/"  // 研发 问答库服务(过期)
#define BXG_NETWORK_ENV_TEST_QALIB_CENTER_DEPRECATED                @"http://portal-api-d1.boxuegu.com/ask-t/"      // 测试 问答精灵服务(过期)
#define BXG_NETWORK_ENV_TEST_QALIB_API_DEPRECATED                   @"http://portal-api-d1.boxuegu.com/ask-api-t/"  // 测试 问答库服务(过期)

//#define BXG_NETWORK_URL_APP
//#define BXG_NETWORK_URL_BBS
//#define BXG_NETWORK_URL_CONSULT
//#define BXG_NETWORK_URL_QALIB_CENTER
//#define BXG_NETWORK_URL_QALIB_API
//#define BXG_NETWORK_URL_NOTE
//#define BXG_NETWORK_URL_USER

#ifdef BXG_SCHEME_DEVELOPMENT               // 研发环境
//#define BXG_NETWORK_URL_APP                 BXG_NETWORK_ENV_DEVELOPMENT
//#define BXG_NETWORK_URL_BBS                 BXG_NETWORK_ENV_DEVELOPMENT
//#define BXG_NETWORK_URL_CONSULT             BXG_NETWORK_ENV_DEVELOPMENT_CONSULT
//#define BXG_NETWORK_URL_QALIB_CENTER        BXG_NETWORK_ENV_DEVELOPMENT_QALIB_CENTER
//#define BXG_NETWORK_URL_QALIB_API           BXG_NETWORK_ENV_DEVELOPMENT_QALIB_API
//#define BXG_NETWORK_URL_NOTE                BXG_NETWORK_ENV_DEVELOPMENT
//#define BXG_NETWORK_URL_USER                BXG_NETWORK_ENV_DEVELOPMENT
//#define BXG_NETWORK_URL_H5                  BXG_NETWORK_ENV_DEVELOPMENT
#define BXG_NETWORK_URL_APP                 BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_BBS                 BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_CONSULT             BXG_NETWORK_ENV_RELEASE_CONSULT
#define BXG_NETWORK_URL_QALIB_CENTER        BXG_NETWORK_ENV_RELEASE_QALIB_CENTER
#define BXG_NETWORK_URL_QALIB_API           BXG_NETWORK_ENV_RELEASE_QALIB_API
#define BXG_NETWORK_URL_NOTE                BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_USER                BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_H5                  BXG_NETWORK_ENV_RELEASE
#endif

#ifdef BXG_SCHEME_TEST1                      // 测试环境
#define BXG_NETWORK_URL_APP                 BXG_NETWORK_ENV_TEST_API_IP_01
#define BXG_NETWORK_URL_BBS                 BXG_NETWORK_ENV_TEST_API_IP_01
#define BXG_NETWORK_URL_CONSULT             BXG_NETWORK_ENV_TEST_CONSULT
#define BXG_NETWORK_URL_QALIB_CENTER        BXG_NETWORK_ENV_TEST_QALIB_CENTER
#define BXG_NETWORK_URL_QALIB_API           BXG_NETWORK_ENV_TEST_QALIB_API
#define BXG_NETWORK_URL_NOTE                BXG_NETWORK_ENV_TEST_API_IP_01
#define BXG_NETWORK_URL_USER                BXG_NETWORK_ENV_TEST_LOCAL_01
#define BXG_NETWORK_URL_H5                  BXG_NETWORK_ENV_TEST_API_IP_01
#endif

#ifdef BXG_SCHEME_TEST2                     // 测试环境
#define BXG_NETWORK_URL_APP                 BXG_NETWORK_ENV_TEST_API_LOCAL_02
#define BXG_NETWORK_URL_BBS                 BXG_NETWORK_ENV_TEST_API_LOCAL_02
#define BXG_NETWORK_URL_CONSULT             BXG_NETWORK_ENV_TEST_CONSULT
#define BXG_NETWORK_URL_QALIB_CENTER        BXG_NETWORK_ENV_TEST_QALIB_CENTER
#define BXG_NETWORK_URL_QALIB_API           BXG_NETWORK_ENV_TEST_QALIB_API
#define BXG_NETWORK_URL_NOTE                BXG_NETWORK_ENV_TEST_API_LOCAL_02
#define BXG_NETWORK_URL_USER                BXG_NETWORK_ENV_TEST_API_LOCAL_02
#define BXG_NETWORK_URL_H5                  BXG_NETWORK_ENV_TEST_API_LOCAL_02
#endif

#ifdef BXG_SCHEME_PRE_PRODUCT               // 预生产环境
#define BXG_NETWORK_URL_APP                 BXG_NETWORK_ENV_PRE_PRODUCT
#define BXG_NETWORK_URL_BBS                 BXG_NETWORK_ENV_PRE_PRODUCT
#define BXG_NETWORK_URL_CONSULT             BXG_NETWORK_ENV_PRE_PRODUCT // 待验证
#define BXG_NETWORK_URL_QALIB_CENTER        BXG_NETWORK_ENV_PRE_PREDUCT_QALIB_CENTER
#define BXG_NETWORK_URL_QALIB_API           BXG_NETWORK_ENV_PRE_PREDUCT_QALIB_API
#define BXG_NETWORK_URL_NOTE                BXG_NETWORK_ENV_PRE_PRODUCT
#define BXG_NETWORK_URL_USER                BXG_NETWORK_ENV_PRE_PRODUCT
#define BXG_NETWORK_URL_H5                  BXG_NETWORK_ENV_PRE_PRODUCT
#endif

#ifdef BXG_SCHEME_RELEASE                   // 正式环境
#define BXG_NETWORK_URL_APP                 BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_BBS                 BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_CONSULT             BXG_NETWORK_ENV_RELEASE_CONSULT
#define BXG_NETWORK_URL_QALIB_CENTER        BXG_NETWORK_ENV_RELEASE_QALIB_CENTER
#define BXG_NETWORK_URL_QALIB_API           BXG_NETWORK_ENV_RELEASE_QALIB_API
#define BXG_NETWORK_URL_NOTE                BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_USER                BXG_NETWORK_ENV_RELEASE
#define BXG_NETWORK_URL_H5                  BXG_NETWORK_ENV_RELEASE
#endif


#endif
/* BXGNetwork_h */
