//
//  RequestURL.h
//  LimiteFree
//
//  Created by Elean on 16/1/21.
//  Copyright © 2016年 Elean. All rights reserved.
//
//网络数据请求地址的宏

#ifndef RequestURL_h
#define RequestURL_h

#define BASE_URL @""
//如果项目中使用的后台是同一个域名 那么 每一个接口的前缀是相同的 可以相同的前缀放在BASE_URL中 不同的部分再放在不同的宏中


#define API_LIMITEFREE @"http://1000phone.net:8088/app/iAppFree/api/limited.php?page=%d&number=20" // 限免接口

#define API_REDUCEPRICE @"http://1000phone.net:8088/app/iAppFree/api/reduce.php?page=%d&number=20" //降价接口

#define API_FREE @"http://1000phone.net:8088/app/iAppFree/api/free.php?page=%d&number=20" //免费接口

#define API_SUBJECT @"" // 专题

#define API_HOT @"http://1000phone.net:8088/app/iAppFree/api/hot.php?page=%d&number=20" // 热榜接口

#define API_CATEGORY @"http://1000phone.net:8088/app/iAppFree/api/appcate.php" //分类接口

#define API_DETAIL @"http://iappfree.candou.com:8080/free/applications/%@?currency=rmb" //详情接口

#define API_LOCATION @"http://iappfree.candou.com:8080/free/applications/recommend?longitude=%f&latitude=%f"



#endif /* RequestURL_h */
