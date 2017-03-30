//
//  BannerWebVC.m
//  SkyDemo
//
//  Created by 何亚慧 on 16/7/22.
//  Copyright © 2016年 Sky. All rights reserved.
//

#import "BannerWebVC.h"

@implementation BannerWebVC




@end

/*
 
 一、iOS调用JS方法
 
 通过iOS调用JS代码实现起来比较方便直接调用UIWebView的方法- (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
 
 1.查询标签
 
 // 查询标签
 NSString *str = @"var word = document.getElementById('word');"
 @"alert(word.innerHTML)";
 [webView stringByEvaluatingJavaScriptFromString:str];
 
 2.为网页添加标签：
 
 NSString *str = @"var img = document.createElement('img');"
 "img.src = 'icon5.jpg';"
 "img.width = 300;"
 "img.heigth = 100;"
 "document.body.appendChild(img);";
 [webView stringByEvaluatingJavaScriptFromString:str];
 
 3.删除网页标签：
 
 // 删除标签
 NSString *str1 = @"var word = document.getElementById('word');"
 @"word.remove();";
 [webView stringByEvaluatingJavaScriptFromString:str1];
 
 4.更改标签：
 
 // 更改
 NSString *str2 = @"var change = document.getElementsByClassName('change')[0];"
 "change.innerHTML = 'hello';";
 NSString *result =  [webView stringByEvaluatingJavaScriptFromString:str2];
 
 
 
 HTML端代码：
 
 <!DOCTYPE html>
 <html lang="en">
 <head>
 <meta charset="UTF-8">
 <title>iOS和H5交互</title>
 </head>
 <body>
 <p id="word">6666666666</p>
 <ul>
 <li class="change">111111</li>
 <li class="haha">222222</li>
 <li>333333</li>
 <li>444444</li>
 </ul>
 <input class="name" placeholder="请输入密码">
 <button onclick="buttonClick()">提交信息</button>
 <script type="text/javascript">
 alert('这个一个弹框');
 </script>
 </body>
 </html>
 
 
 */
