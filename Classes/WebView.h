//
//  WebView.h
//  BattleBoats
//
//  Created by Dylan Jones on 26/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
	
	UIWebView *webView;
	UIButton *buttonBack;
	UIButton *buttonMap;


}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) UIButton * buttonBack;
@property (nonatomic,retain) UIButton * buttonMap;

- (void) goBack;
- (void) gotoMap;

@end



