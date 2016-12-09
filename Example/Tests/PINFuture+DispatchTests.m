//
//  DispatchTests.m
//  PINFuture
//
//  Created by Chris Danford on 12/5/16.
//  Copyright © 2016 Chris Danford. All rights reserved.
//

// https://github.com/Specta/Specta

#import "PINFuture.h"

#import "TestUtil.h"

dispatch_queue_t backgroundQueue() {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

SpecBegin(PINFutureDispatchSpecs)

describe(@"dispatch", ^{
    PINExecutionContext context = [PINExecution background];

    it(@"resolve on background queue", ^{
        NSString *value = @4;
        PINFuture<NSString *> *future = [PINFuture<NSString *> dispatchWithContext:context block:^PINFuture<NSString *> * _Nonnull{
            return [PINFuture futureWithValue:value];
        }];
        expectFutureToResolveWith(self, future, value);
    });

    it(@"reject on background queue", ^{
        NSError *error = [[NSError alloc] init];
        PINFuture<NSString *> *future = [PINFuture<NSString *> dispatchWithContext:context block:^PINFuture<NSString *> * _Nonnull{
            return [PINFuture futureWithError:error];
        }];
        expectFutureToRejectWith(self, future, error);
    });
});

SpecEnd
