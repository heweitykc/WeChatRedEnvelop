#import <UIKit/UIKit.h>


@interface SKUIOfferView : UIControl

- (void)_buttonAction:(id)arg1;

@end

@interface SKUIItemOfferButton : UIControl

@property (nonatomic, copy) NSString *title;

@end

@interface SKUIStorePageSectionsViewController : UIViewController 

-(void)findAllSubviews:(UIView *)view;
-(void)timerAction;
@end