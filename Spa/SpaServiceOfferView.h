//
//  SpaServiceOfferView.h
//  Spa
//
//  Created by Surendran Thiyagarajan on 3/8/17.
//  Copyright © 2017 suren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpaServiceOffer.h"

@protocol SpaServiceOfferViewDelegate <NSObject>

- (void)spaServiceOfferViewReserveAction:(SpaServiceOffer *)serviceOffer;

@end

@interface SpaServiceOfferView : UIView

@property (nonatomic) id <SpaServiceOfferViewDelegate> delegate;

- (void)updateOfferDetails:(SpaServiceOffer *)serviceOffer;

@end
