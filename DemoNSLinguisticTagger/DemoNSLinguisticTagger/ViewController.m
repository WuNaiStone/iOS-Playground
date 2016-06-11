//
//  ViewController.m
//  DemoNSLinguisticTagger
//
//  Created by Chris Hu on 16/6/10.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self demoNSLinguisticTagger];
}

/**
 *  NSLinguisticTagger 在语言学功能上来讲是一把名副其实的瑞士军刀，它可以将自然语言的字符串标记为单词、确定词性和词根、划分出人名地名和组织名称、告诉你字符串使用的语言和语系。
 
 对于我们大多数人来说，这其中蕴含着意义远超过我们所知道的，但或许也只是我们没有合适的机会使用而已。但是，几乎所有使用某种方式来处理自然语言的应用如果能够用上 NSLinguisticTagger ，或许就会润色不少，没准会催生一批新特性呢。
 配合潜在语义映射（Latent Semantic Mapping）http://developer.apple.com/library/mac/#documentation/LatentSemanticMapping/Reference/LatentSemanticMapping_header_reference/Reference/reference.html 库，我们就可以推断出合理解释
 
 不同的scheme:
 NSLinguisticTagSchemeTokenType: 将短语在大粒度上分成词语,标点符号,空格等.
 NSLinguisticTagSchemeLexicalClass: 将短语根据类型分为话语部分,标点空格等.
 NSLinguisticTagSchemeNameType: 将短语根据是否为命名实体分类.
 NSLinguisticTagSchemeNameTypeOrLexicalClass
 
 打印log:
 2016-06-10 21:34:12.377 DemoNSLinguisticTagger[12193:4994938] What : Pronoun, 代词
 2016-06-10 21:34:12.378 DemoNSLinguisticTagger[12193:4994938] is : Verb, 动词
 2016-06-10 21:34:12.378 DemoNSLinguisticTagger[12193:4994938] the : Determiner, 限定词
 2016-06-10 21:34:12.378 DemoNSLinguisticTagger[12193:4994938] weather : Noun, 名词
 2016-06-10 21:34:12.378 DemoNSLinguisticTagger[12193:4994938] in : Preposition, 介词
 2016-06-10 21:34:12.378 DemoNSLinguisticTagger[12193:4994938] San Francisco : PlaceName, 地名
 */
- (void)demoNSLinguisticTagger {
    NSString *question = @"What is the weather in San Francisco?";
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerJoinNames;
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:options];
    tagger.string = question;
    [tagger enumerateTagsInRange:NSMakeRange(0, question.length) scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass options:options usingBlock:^(NSString * _Nonnull tag, NSRange tokenRange, NSRange sentenceRange, BOOL * _Nonnull stop) {
        NSString *token = [question substringWithRange:tokenRange];
        NSLog(@"%@ : %@", token, tag);
        
        if ([tag isEqualToString:@"PlaceName"]) {
            NSString *place = tag;
            NSLog(@"placeName : %@", place);
        }
        
    }];
}

@end
