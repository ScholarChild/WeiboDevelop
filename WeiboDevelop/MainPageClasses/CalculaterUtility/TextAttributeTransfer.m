//
//  TextAttributeTranster.m
//  WeiboDevelop
//
//  Created by Ibokan on 15/12/3.
//  Copyright (c) 2015年 geek. All rights reserved.
//

#import "TextAttributeTransfer.h"
#import "WBRequestManager.h"
#import "EmoticonTransfer.h"
#import "NSObject+UnicodeDestribution.h"

@interface TextAttributeTransfer()
{
    CGFloat _fontSize;
}

@property (retain) NSMutableAttributedString* tmpAttributeText;
@property (retain) NSMutableString* searchText;

@end



@implementation TextAttributeTransfer

- (instancetype)initWithString:(NSString* )string fontSize:(CGFloat)size;
{
    if (self = [super init]) {
        _searchText = [[NSMutableString alloc]initWithString:string];
        _tmpAttributeText = [[NSMutableAttributedString alloc]initWithString:string];
        _fontSize = size;
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
    [self transEmojiCode];
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
                                           NSFontAttributeName : [UIFont systemFontOfSize:_fontSize],
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
        NSURL* linkURL = [NSURL URLWithString:shortURL];
        [_tmpAttributeText addAttribute:NSLinkAttributeName value:linkURL range:transRange];
        [_tmpAttributeText replaceCharactersInRange:transRange withString:@"网页链接"];
        [_searchText replaceCharactersInRange:transRange withString:@"网页链接"];
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

- (void)transEmojiCode
{
    EmoticonTransfer* transfer = [EmoticonTransfer shareTransfer];
    NSArray* tmpArr = [self rangValuesInTextWithRegular:@"\\[[^\\]]+\\]"];
    NSMutableArray* transRangeArr = [NSMutableArray arrayWithArray:tmpArr];
    while ([transRangeArr count] > 0) {
        NSTextCheckingResult* lastResult = [transRangeArr lastObject];
        NSRange transRange = lastResult.range;
        NSString* transWord = [_searchText substringWithRange:transRange];
        
        NSString* emojiImageName = [transfer imageEmojiNamewithCode:transWord];
        NSTextAttachment *emojiAttachment = [[NSTextAttachment alloc] init];
        emojiAttachment.image = [UIImage imageNamed:emojiImageName];
        emojiAttachment.bounds = CGRectMake(0, 0, _fontSize, _fontSize);
        NSAttributedString *emojiAttrStr = [NSAttributedString attributedStringWithAttachment:emojiAttachment];
        [_tmpAttributeText replaceCharactersInRange:transRange withAttributedString:emojiAttrStr];
        [_searchText replaceCharactersInRange:transRange withString:@"x"];
        [transRangeArr removeObject:lastResult];
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













