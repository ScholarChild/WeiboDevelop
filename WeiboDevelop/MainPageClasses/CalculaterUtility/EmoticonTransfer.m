//
//  EmoticonTransfer.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/18.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "EmoticonTransfer.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EmoticonType) {
    EmoticonTypeImage = 0,
    EmoticonTypeEncoding = 1,
    EmoticonTypeNotFound = NSNotFound
};

@interface EmoticonTransfer()
{
    NSMutableDictionary* _encodingEmoji;
    NSMutableDictionary* _imageEmoji;
    NSBundle* emoticonBundle;
}
@end

@implementation EmoticonTransfer

- (NSString*)imageEmojiNamewithCode:(NSString*)code
{
    NSString* imageName = nil;
    NSArray* imageGroups = [self getAllImageEmoticonGroupName];
    for (NSString* groupName in imageGroups) {
        NSDictionary* encodingEmojis = [self getImagaEmoticonListWithGroupName:groupName];
        imageName = [encodingEmojis objectForKey:code];
        if (imageName) {
            break;
        }
    }
    return imageName;
}

- (NSArray*)getAllEncodingEmoticonGroupName
{
    return [_encodingEmoji allKeys];
}

- (NSArray*)getAllImageEmoticonGroupName
{
    return [_imageEmoji allKeys];
}

- (NSDictionary*)getImagaEmoticonListWithGroupName:(NSString*)groupName
{
    return [_imageEmoji objectForKey:groupName];
}

- (NSArray*)getEncodingEmoticonListWithGroupName:(NSString*)groupName
{
    return [_encodingEmoji objectForKey:groupName];
}

+ (instancetype)shareTransfer
{
    static EmoticonTransfer* _transferInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _transferInstance = [[EmoticonTransfer alloc]init];
    });
    return _transferInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initEmojiPool];
        [self loadEmoticonBundle];
    }
    return self;
}

- (void)initEmojiPool
{
    _encodingEmoji = [NSMutableDictionary new];
    _imageEmoji = [NSMutableDictionary new];
}

- (void)loadEmoticonBundle
{
    emoticonBundle = [NSBundle bundleWithPath:
                                [[NSBundle mainBundle] pathForResource:@"Emoticons"
                                                                ofType:@"bundle"]];
    NSDictionary* bundleInfo = [NSDictionary dictionaryWithContentsOfFile:[emoticonBundle pathForResource:@"emoticons" ofType:@"plist"]];
    NSUInteger packageCount = [bundleInfo[@"packages"] count];
    for (NSInteger packageIndex = 0; packageIndex < packageCount; packageIndex++) {
        NSString* packageName = bundleInfo[@"packages"][packageIndex][@"id"];
        NSArray* emoticonList = [self emoticonsInfoWithPackageName:packageName];
        [self addEmoticonWithList:emoticonList groupName:packageName];
    }
}

- (NSArray*)emoticonsInfoWithPackageName:(NSString*)packageName
{
    NSString* packageInfoPath = [NSString stringWithFormat:@"%@/%@/%@",
                                 [emoticonBundle bundlePath],packageName,@"info.plist"];
    NSDictionary* packageInfo = [NSDictionary dictionaryWithContentsOfFile:packageInfoPath];
    return packageInfo[@"emoticons"];
}

- (void)addEmoticonWithList:(NSArray*)emoticonList groupName:(NSString*)groupName
{
    EmoticonType type = [self typeOfList:emoticonList];
    switch (type) {
        case EmoticonTypeImage:
            [self addImageEmojiFromList:emoticonList groupName:groupName];
            break;
        case EmoticonTypeEncoding:
            [self addEncodingEmojiFromList:emoticonList groupName:groupName];
            break;
        default:
            break;
    }
}

- (EmoticonType)typeOfList:(NSArray*)emoticonList
{
    return [emoticonList[0][@"type"] integerValue];
}

- (void)addImageEmojiFromList:(NSArray *)emoticonList groupName:(NSString*)groupName
{
    NSUInteger listCount = [emoticonList count];
    NSMutableDictionary* imageEmotionList = [NSMutableDictionary dictionaryWithCapacity:[emoticonList count]];
    
    for (int listIndex = 0; listIndex < listCount; listIndex++) {
        NSString* codeString = emoticonList[listIndex][@"chs"];
        NSString* imageName = emoticonList[listIndex][@"png"];
        NSString* imagePath = [NSString stringWithFormat:@"%@/%@/%@",
                               [emoticonBundle bundlePath],groupName,imageName];
        [imageEmotionList setObject:imagePath forKey:codeString];
    }
    [_imageEmoji setObject:imageEmotionList forKey:groupName];
}

- (void)addEncodingEmojiFromList:(NSArray *)emoticonList groupName:(NSString*)groupName
{
    NSUInteger listCount = [emoticonList count];
    NSMutableArray* encodingEmotionList = [NSMutableArray arrayWithCapacity:listCount];
    
    unsigned int unicode = 0;
    for (int listIndex = 0; listIndex < listCount; listIndex++) {
        NSString* codeString = emoticonList[listIndex][@"code"];
        [[NSScanner scannerWithString:codeString] scanHexInt:&unicode];
        NSStringEncoding encoding = [self checkStringUTFEncodingWithUnicode:unicode];
        NSString* emoticonString = [[NSString alloc]initWithBytes:&unicode
                                                           length:sizeof(unicode) encoding:encoding];
        [encodingEmotionList addObject:emoticonString];
    }
    [_encodingEmoji setObject:[NSArray arrayWithArray:encodingEmotionList] forKey:groupName];
}

- (NSStringEncoding)checkStringUTFEncodingWithUnicode:(unsigned int)code
{
    union
    {
        int a;
        char b;
    }c;
    c.a = 1;
    bool isLittleEndian = c.b;
    bool is32UTF = (code > 0xFFFF);
    NSStringEncoding encoding = 0x90000100;
    encoding += (is32UTF << 27);
    encoding += (isLittleEndian << 26);
    return encoding;
}

@end




