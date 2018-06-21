//
//  Repo.h
//  GitHub Repos
//
//  Created by Will Chew on 2018-06-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic,strong) NSDictionary *dictionary;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
