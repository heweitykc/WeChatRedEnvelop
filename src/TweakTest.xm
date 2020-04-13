#import "AppStore.h"

SKUIOfferView* offerView;
SKUIItemOfferButton* offerButton;
NSTimer* downloadTimer;

%hook SKUIStorePageSectionsViewController

- (void)viewDidAppear:(BOOL)animated {	
    %log;
	%orig;
	
	[self findAllSubviews:self.view];

	if (offerButton && offerView) {
		[offerView _buttonAction:offerButton];
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
			NSLog(@"SKUIOfferView .. . .. ");
		}
		if ([subView isKindOfClass:NSClassFromString(@"SKUIItemOfferButton")]) {
			offerButton = (SKUIItemOfferButton*)subView;
			NSLog(@"SKUIItemOfferButton .. . .. ");
		}
    }
}

%end
