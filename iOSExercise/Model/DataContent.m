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
        _HeadingArray = [jsonDictionary objectForKey:@"title"];
        _DescArray = [jsonDictionary objectForKey:@"description"];
        _ImageArray = [jsonDictionary objectForKey:@"imageHref"];
        //_PageTitle = [ objectForKey:@"telephone"];
    }
    return self;
}
@end
