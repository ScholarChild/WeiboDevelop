//
//  TextAttributeTranster.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "TextAttributeTranster.h"
#import "WBURLAnalyser.h"
@interface TextAttributeTranster()

@property (retain) NSMutableAttributedString* tmpAttributeText;
@property (retain) NSString* searchText;

@end



@implementation TextAttributeTranster

- (instancetype)initWithString:(NSString *)string
{
    if (self = [super init]) {
        _searchText = string;
        _tmpAttributeText = [[NSMutableAttributedString alloc]initWithString:string];
    }
    return self;
}


- (NSAttributedString *)attrubuteText
{
    [self transformAttrubute];
    return [[NSAttributedString alloc]initWithAttributedString:_tmpAttributeText];
}

- (void)transformAttrubute
{
    [self transTopic];
    [self transUserName];
    [self transShortURL];
    [self addDefaultAttribute];
}

- (void)addDefaultAttribute
{
    NSMutableParagraphStyle* paragraphStyle = [NSMutableParagraphStyle new];

    paragraphStyle.paragraphSpacing = weiboCellviewInterval;
    paragraphStyle.firstLineHeadIndent = weiboCellviewInterval - 7.0f;
    paragraphStyle.headIndent = weiboCellviewInterval - 7.0f;
    paragraphStyle.tailIndent = CGRectGetWidth([[UIScreen mainScreen] bounds]) - weiboCellviewInterval;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    
    NSDictionary* textDefaultAttribute = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:17.0f],
                                           NSParagraphStyleAttributeName : paragraphStyle
                                           };
    
    [_tmpAttributeText addAttributes:textDefaultAttribute range:NSMakeRange(0, [_tmpAttributeText length])];
}


- (void)transShortURL
{
    NSArray* tmpArr = [self rangValuesInTextWithRegular:@"http:\\/\\/t.cn\\/[a-zA-Z0-9]*"];
    NSMutableArray* transRangeArr = [NSMutableArray arrayWithArray:tmpArr];
    while ([transRangeArr count] > 0) {
        NSValue* lastValue = [transRangeArr lastObject];
        NSRange transRange = [lastValue rangeValue];
        NSString* shortURL = [_searchText substringWithRange:transRange];
        NSURL* linkURL = [[WBURLAnalyser new] longURLFromShortURLString:shortURL];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
        [_tmpAttributeText replaceCharactersInRange:transRange withString:@"网页链接"];
        _searchText = [_searchText stringByReplacingCharactersInRange:transRange withString:@"网页链接"];
        [transRangeArr removeObject:lastValue];
    }
}

- (void)transTopic
{
    NSArray* transRangeArr = [self rangValuesInTextWithRegular:@"#[^#]+#"];
    NSInteger count = [_searchText length];
    
    for (NSValue* value in transRangeArr) {
        NSRange transRange = [value rangeValue];
        NSString* keyword = [_searchText substringWithRange:transRange];
        keyword = [keyword substringFromIndex:1];
        keyword = [keyword substringToIndex:([keyword length] - 1)];
        NSURL* linkURL = [[WBURLAnalyser new] topicSearchRequestWithSearchKeyword:keyword];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
    }
}

- (void)transUserName
{
    NSArray* transRangeArr = [self rangValuesInTextWithRegular:@"@\\S+(?= |@|$)"];
    
    for (NSValue* value in transRangeArr) {
        NSRange transRange = [value rangeValue];
        NSString* transWord = [_searchText substringWithRange:transRange];
        transWord = [transWord substringFromIndex:1];
        NSURL* linkURL = [[WBURLAnalyser new] personalRequestWithUserName:transWord];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
    }
}


- (NSArray*)rangValuesInTextWithRegular:(NSString*)regular
{
    NSMutableArray* tmpArr = [NSMutableArray arrayWithCapacity:1];
    
    NSString* searchText = [_searchText copy];
    NSInteger textLength = [_searchText length];
    NSRange searchRange = NSMakeRange(0, textLength);
    NSRange transRange = NSMakeRange(0, 0);

    for (NSInteger searchLoc = 0; searchLoc < textLength; searchLoc = NSMaxRange(transRange)) {
        searchRange = NSMakeRange(searchLoc, (textLength - searchLoc));
        transRange = [searchText rangeOfString:regular
                                       options:NSRegularExpressionSearch
                                         range:searchRange];
        if (transRange.location != NSNotFound) {
             NSValue* rangeValue =  [NSValue valueWithRange:transRange];
            [tmpArr addObject:rangeValue];
        }
    }
    return [NSArray arrayWithArray:tmpArr];
}










@end
