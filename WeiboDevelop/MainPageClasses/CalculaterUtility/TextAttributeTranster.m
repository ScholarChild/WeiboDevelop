//
//  TextAttributeTranster.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "TextAttributeTranster.h"
#import "WBRequestManager.h"
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
        NSTextCheckingResult* lastResult = [transRangeArr lastObject];
        NSRange transRange = lastResult.range;
        NSString* shortURL = [_searchText substringWithRange:transRange];
        NSURL* linkURL = [[WBRequestManager new] longURLFromShortURLString:shortURL];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
        [_tmpAttributeText replaceCharactersInRange:transRange withString:@"网页链接"];
        _searchText = [_searchText stringByReplacingCharactersInRange:transRange withString:@"网页链接"];
        [transRangeArr removeObject:lastResult];
    }
}

- (void)transTopic
{
    NSArray* transRangeArr = [self rangValuesInTextWithRegular:@"#[^#]+#"];
    
    for (NSTextCheckingResult* result in transRangeArr) {
        NSRange transRange = result.range;
        NSString* keyword = [_searchText substringWithRange:transRange];
        keyword = [keyword substringFromIndex:1];
        keyword = [keyword substringToIndex:([keyword length] - 1)];
        NSURL* linkURL = [[WBRequestManager new] topicSearchRequestWithSearchKeyword:keyword];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
    }
}

- (void)transUserName
{
    NSArray* transRangeArr = [self rangValuesInTextWithRegular:@"@[a-zA-Z0-9\\u4e00-\\u9fa5_-]+"];
    
    for (NSTextCheckingResult* result in transRangeArr) {
        NSRange transRange = result.range;
        NSString* transWord = [_searchText substringWithRange:transRange];
        transWord = [transWord substringFromIndex:1];
        NSURL* linkURL = [[WBRequestManager new] personalRequestWithUserName:transWord];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
    }
}


- (NSArray*)rangValuesInTextWithRegular:(NSString*)regular
{
    NSError *error=NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regular options:NSRegularExpressionCaseInsensitive error:&error];
    NSAssert(error == NULL,@"regular err");
    
    return [regex matchesInString:self.searchText options:0 range:NSMakeRange(0,[self.searchText length])];
}

@end













