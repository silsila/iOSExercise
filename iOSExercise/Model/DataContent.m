//
//  DataContent.m
//  iOSExercise
//
//  Created by Silsila on 20/05/18.
//  Copyright © 2018 Abc. All rights reserved.
//

#import "DataContent.h"

@implementation DataContent
// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary
{
    if(self = [self init])
    {
        // Assign all properties with keyed values from the dictionary
        _HeadingString = [jsonDictionary objectForKey:@"title"];
        _DescString = [jsonDictionary objectForKey:@"description"];
        _ImageString = [jsonDictionary objectForKey:@"imageHref"];
    }
    return self;
}
@end
