//
//  ZDDManHuaListModel.h
//  V2EX
//
//  Created by Maker on 2019/2/16.
//  Copyright © 2019 binary. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDDBookConfigModel;
@class ZDDBookListModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZDDManHuaListModel : NSObject


@property (nonatomic, assign) NSInteger book_id;
@property (nonatomic, assign) NSInteger siteid;
@property (nonatomic, assign) NSInteger union_type;
@property (nonatomic, assign) NSInteger union_id;
@property (nonatomic, assign) NSInteger istop;
@property (nonatomic, assign) NSInteger ordernum;
@property (nonatomic, assign) NSInteger version_filter;

@property (nonatomic, strong) NSString *version_end;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) ZDDBookConfigModel *config;

@property (nonatomic, assign) NSInteger bookcomic_order;
@property (nonatomic, assign) NSInteger bookcomic_imgstyle;
@property (nonatomic, assign) NSInteger advertise_sdktype;
@property (nonatomic, assign) NSInteger book_datasource;
@property (nonatomic, assign) NSInteger book_intellrecommend;
@property (nonatomic, strong) NSString *advertise_location;

@property (nonatomic, strong) NSArray<ZDDBookListModel *>*comic_info;


@end



@interface ZDDBookConfigModel : NSObject

@property (nonatomic, strong) NSString *display_type;
@property (nonatomic, assign) NSInteger isautoslide;
@property (nonatomic, assign) NSInteger isshowtitle;
@property (nonatomic, assign) NSInteger interwidth;
@property (nonatomic, assign) NSInteger outerwidth;
@property (nonatomic, strong) NSString *horizonratio;
@property (nonatomic, assign) NSInteger isshowdetail;
@property (nonatomic, assign) NSInteger order_type;
@property (nonatomic, assign) NSInteger isshowchange;



@end



@interface ZDDBookListModel : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger comic_id;
@property (nonatomic, strong) NSString *comic_name;
@property (nonatomic, strong) NSString *total_view_num;
@property (nonatomic, assign) NSInteger update_time;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *img_url;
@property (nonatomic, strong) NSString *last_comic_chapter_name;
@property (nonatomic, assign) NSInteger ordernum;



@end

NS_ASSUME_NONNULL_END
