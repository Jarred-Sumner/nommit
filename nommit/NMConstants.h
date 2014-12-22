//
//  NMConstants.h
//  nommit
//
//  Created by Jarred Sumner on 10/2/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#define DEVELOPMENT_URL @"http://localhost:3000/api/v1"
#define DEVELOPMENT_STRIPE_KEY @"pk_test_evT0Hl8iSqKRXKkOvjJfPsKt"

#define PRODUCTION_URL @"http://www.getnommit.com/api/v1"
#define PRODUCTION_STRIPE_KEY @"pk_live_lLUJxo6DJJiHvuCwFtxPlYmS"

#define DEVELOPMENT

#ifdef DEVELOPMENT
    #define API_URL DEVELOPMENT_URL
    #define STRIPE_KEY DEVELOPMENT_STRIPE_KEY
    #define MIXPANEL_TOKEN @"c266a2abccc24707aa55c8869bb88367"
#else
    #define API_URL PRODUCTION_URL
    #define STRIPE_KEY PRODUCTION_STRIPE_KEY
    #define MIXPANEL_TOKEN @"de0a7915f912ad72f34a490a940449da"
#endif


typedef void (^NMCompletionBlock)();
