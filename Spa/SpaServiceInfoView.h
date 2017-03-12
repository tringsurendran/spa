//
//  SpaServiceInfolView.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/8/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpaServiceInfoView;

@protocol SpaServiceInfoViewDelegate <NSObject>

- (void)didTapOnPartySize:(SpaServiceInfoView *)view;

@end

@interface SpaServiceInfoView : UIView

@property (nonatomic) NSNumber *partySize;
@property (nonatomic, weak) id <SpaServiceInfoViewDelegate> delegate;

@end
