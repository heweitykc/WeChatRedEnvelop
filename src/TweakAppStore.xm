%hook SKUIStorePageSectionsViewController

SKUIOfferView* offerView;
SKUIItemOfferButton* offerButton;

- (void)viewDidAppear:(BOOL)animated {	
    %log;
	%orig;
     
    // 遍历所有子 View，找到 offerButton 、offerView
	[self findAllSubviews:self.view];

	if (offerButton && offerView) {
        // 执行下载操作
	    [offerView _buttonAction:offerButton];
        // 每秒去 check 一下，是否下载完成
	    downloadTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
	}		
}
%new
-(void)timerAction {
	if ([offerButton.title isEqualToString:@"打开"]) {
        // 发送下载完成的通知
		[[NSNotificationCenter defaultCenter] postNotificationName:@"textChangedAction" object:nil];

		downloadTimer = nil;
	}
}
%new
-(void)findAllSubviews:(UIView *)view
 {
    for (UIView *subView in view.subviews) {
        if (subView.subviews.count) {
            [self findAllSubviews:subView];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"SKUIOfferView")]) {
			offerView = (SKUIOfferView*)subView;
		}
		if ([subView isKindOfClass:NSClassFromString(@"SKUIItemOfferButton")]) {
			offerButton = (SKUIItemOfferButton*)subView;
		}
    }
}
%end
