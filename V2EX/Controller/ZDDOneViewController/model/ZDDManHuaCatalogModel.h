//
//  ZDDManHuaCatalogModel.h
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDDManHuaImageQualityModel;
@class ZDDManHuaCapterModel;

@interface ZDDManHuaCatalogModel : NSObject

@property (nonatomic, assign) NSInteger servicetime;
@property (nonatomic, strong) NSString *comic_name;
@property (nonatomic, strong) NSString *update_status_str;
@property (nonatomic, assign) NSInteger comic_status;
@property (nonatomic, strong) NSString *comic_author;
@property (nonatomic, strong) NSString *comic_desc;
@property (nonatomic, assign) NSInteger copyright_type;
@property (nonatomic, assign) NSInteger last_chapter_id;
@property (nonatomic, assign) NSInteger readtype;
@property (nonatomic, assign) NSInteger human_type;
@property (nonatomic, strong) NSString *background_color;
@property (nonatomic, strong) NSString *comic_share_url;
@property (nonatomic, assign) NSInteger update_time;
@property (nonatomic, strong) NSString *cover_charge_status;
@property (nonatomic, assign) NSInteger shoucang;
@property (nonatomic, assign) NSInteger renqi;
@property (nonatomic, strong) NSArray <ZDDManHuaCapterModel *>*comic_chapter;


//"allprice":1943,
//"charge_status":"10000000000000000000",
//"charge_paid":0,
//"charge_coin_free":1,
//"charge_share_free":1,
//"charge_advertise_free":1,
//"charge_truetime_free":1,
//"charge_limittime_free":1,
//"charge_limitline_free":1,
//"charge_vip_free":1,
//"charge_spread_free":1,
//"charge_game_free":1,
//"charge_coupons_free":1,
//"charge_lottery_free":1,
//"charge_limittime_paid":1,
//"charge_limitline_paid":1,
//"charge_others_paid":1,
//"charge_credit_paid":1,
//"charge_free_turn":1,
//"isshowdata":1,
//"cover_list":[
//              "http://image.mhxk.com/mh/106166.jpg-600x800.jpg.webp",
//              "http://image.mhxk.com/mh/106166_2_1.jpg-800x400.jpg.webp"
//              ]

@end



@interface ZDDManHuaCapterModel : NSObject

@property (nonatomic, strong) NSString *chapter_id;
@property (nonatomic, strong) NSString *chapter_name;
@property (nonatomic, assign) NSInteger chapter_topic_id;
@property (nonatomic, assign) NSInteger create_date;
@property (nonatomic, assign) NSInteger islock;
@property (nonatomic, strong) NSString *chapter_share_url;
@property (nonatomic, assign) NSInteger download_price;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) ZDDManHuaImageQualityModel *chapter_image;

@property (nonatomic, assign) NSInteger isbuy;
@property (nonatomic, assign) NSInteger start_num;
@property (nonatomic, assign) NSInteger end_num;

@property (nonatomic, strong) NSString *chapter_domain;
@property (nonatomic, strong) NSString *source_url;
@property (nonatomic, strong) NSString *rule;
@property (nonatomic, strong) NSString *webview;
@property (nonatomic, assign) NSInteger show_spiltline;


@end

@interface ZDDManHuaImageQualityModel : NSObject

@property (nonatomic, strong) NSString *low;
@property (nonatomic, strong) NSString *middle;
@property (nonatomic, strong) NSString *high;


@end
