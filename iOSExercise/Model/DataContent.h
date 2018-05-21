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
//declared to get imageurl
@property (readonly) NSString *ImageString;
//declared to get headingstring
@property (readonly) NSString *HeadingString;
//declared to get descriptionstring
@property (readonly) NSString *DescString;

@end
