//
//  UNDAddPromiceViewController.h
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNDPromiseDataSourceOutputProtocol.h"


@interface UNDAddPromiceViewController : UIViewController

@property (nonatomic, weak) id <UNDPromiseDataSourceOutputProtocol> delegate;

@end
