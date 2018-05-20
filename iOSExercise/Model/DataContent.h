//
//  DataContent.h
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataContent : NSObject
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;
@property (readonly) NSString *ImageArray;
@property (readonly) NSString *HeadingArray;
@property (readonly) NSString *DescArray;

@end
