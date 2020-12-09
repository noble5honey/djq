//
//  YCHNetBiz.h
//  YCHManage
//
//  Created by sunny on 2020/9/25.
//  Copyright © 2020 com.chinaums.ios.chinaumsonline. All rights reserved.
//

#ifndef YCHNetBiz_h
#define YCHNetBiz_h

////服务器外网地址
//#define product         @"http://180.117.162.10:18080/sk-fish/"
////服务器地址  内网
//#define test            @"http://172.16.103.222:8090/sk-fish/"
//
//#define YCH_URL_Server    test
////图片地址
//#define YCH_image_url_server  test_Image
//
//
//#define product_Image    @"http://180.117.162.10:18080/sk-fish/img/"
//#define test_Image       @"http://172.16.103.222:8090/sk-fish/img/"


/**
 * 开放平台环境，0-测试环境，1-生产环境
 */
#define OP_PLATFORM_CONFIG 0

#if OP_PLATFORM_CONFIG

#define YCH_URL_Server        @"http://180.117.162.10:18080/sk-fish/"       //服务器外网地址

#define YCH_image_url_server  @"http://180.117.162.10:18080/sk-fish/img/"   //照片地址  外网

#else

//#define YCH_URL_Server         @"http://172.16.103.222:8090/sk-fish/"       //服务器内网地址
//
//#define YCH_image_url_server   @"http://172.16.103.222:8090/sk-fish/img/"   //照片地址  内网

#define YCH_URL_Server         @"http://2.39.88.118:8084/sk-fish/"       //稽伟伟电脑地址

#define YCH_image_url_server   @"http://2.39.88.118:8084/sk-fish/img/"   //稽伟伟照片地址  内网

#endif

#define YCH_login_Server   @"login"

#define YCH_test_Server    @"test"

#define YCH_Login_Register_Server     @"register"

#define YCH_HomePage_Query_Server     @"api/fish/select"

#define YCH_checkRecord_Query_Server  @"api/check/select"

#define YCH_matter_item_Query_Server  @"api/matter/select"

#define YCH_examine_correct_Server    @"api/rectification/add"

#define YCH_examine_new_add           @"api/check/add"   //检查新增

#define YCH_upload_file_Server        @"api/file/upload"

#define YCH_role_query_Server         @"api/role/all"  //角色部门查询

#define YCH_area_query_Server         @"api/sysDict/area"  //片区查询

#define YCH_assistChek_query_Server   @"api/help/select"   //协同检查列表

#define YCH_resultNoti_query_Server   @"api/outcome/select" //结果通告列表

#define YCH_assistCheck_add_Server    @"api/help/add"  //协同检查 新增

#define YCH_Auto_generate_Server      @"api/check/outcomeSelect"  //自动生成内容

#define YCH_ResultNoti_add_Server     @"api/outcome/add"

#define YCH_overView_query_Server     @"api/dashboard/select"  //预览页面内容

#define YCH_exmine_read_confirm_server  @"api/help/read/"   //协查通告-已阅读

#define YCH_noti_read_confirm_server  @"api/outcome/read/"    //结果通告-已阅读

#endif /* YCHNetBiz_h */
