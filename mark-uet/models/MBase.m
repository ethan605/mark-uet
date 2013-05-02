//
//  NRBase.m
//  news-recommender
//
//  Created by Ethan Nguyen on 1/10/13.
//  Copyright (c) 2013 UET. All rights reserved.
//

#import "MBase.h"
#import "objc/runtime.h"

@interface MBase ()

- (void)assignProperties:(NSDictionary *)dict;

@end

@implementation MBase

-(id)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self assignProperties:dict];
    }
    
    return self;
}

- (void)assignProperties:(NSDictionary *)dict {
    for (NSString *key in dict) {
        NSObject *value = [dict valueForKey:key];
        NSString *name = [key isEqualToString:@"_id"] || [key isEqualToString:@"id"] ? @"Id" : key;
        objc_property_t property =
        class_getProperty([self class], [name cStringUsingEncoding:NSUTF8StringEncoding]);
        if (property == NULL) {
#ifdef DEBUG
            DLog(@"no property for key %@", key);
#endif
            continue;
        }
        
        NSString *attributesString = [NSString stringWithUTF8String:
                                      property_getAttributes(property)];
        NSString *typeString = [[[attributesString componentsSeparatedByString:@","]
                                 objectAtIndex:0] substringFromIndex:1];
        if ([typeString length] == 1 &&
            [@"cdifls" rangeOfString:typeString].location != NSNotFound) {
            if ([value isKindOfClass:[NSNumber class]]) {
                [self setValue:value forKey:name];
            }
#ifdef DEBUG
            else {
                DLog(@"property %@ does not match type %@",
                     name, [value class]);
            }
#endif
        } else if ([typeString rangeOfString:@"@"].location != NSNotFound) {
            NSError *error = NULL;
            NSRegularExpression *regex =
            [NSRegularExpression regularExpressionWithPattern:@"@\"(.+)\""
                                                      options:NSRegularExpressionCaseInsensitive
                                                        error:&error];
            NSArray *matches = [regex matchesInString:typeString
                                              options:0
                                                range:NSMakeRange(0, [typeString length])];
            if ([matches count] > 0) {
                NSTextCheckingResult *match = [matches objectAtIndex:0];
                NSString *className = [typeString substringWithRange:[match rangeAtIndex:1]];
                Class aClass = NSClassFromString(className);
                if ([value isKindOfClass:[NSNull class]]) {
#ifdef DEBUG
                    DLog(@"do not set null value for property %@", name);
#endif
                } else if ([value isKindOfClass:NSClassFromString(className)])
                    [self setValue:value forKey:name];
                else if (class_respondsToSelector(aClass, @selector(initWithDict:)) &&
                           [value isKindOfClass:[NSDictionary class]]) {
                    [self setValue:[[aClass alloc] initWithDict:(NSDictionary*)value]
                            forKey:name];
                }
#ifdef DEBUG
                else
                    DLog(@"property %@ has type %@, while value has type %@",
                         name, className, [value class]);
#endif
            }
#ifdef DEBUG
            else
                DLog(@"unknown type %@", typeString);
#endif
        }
#ifdef DEBUG
        else
            DLog(@"unknown type %@", typeString);
#endif
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
#ifdef DEBUG
    DLog(@"cannot set value for key %@", key);
#endif
}

- (NSString*)Id {
    return nil;
}

#ifdef DEBUG
#undef DEBUG
#endif

@end
