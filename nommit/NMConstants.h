//
//  NMConstants.h
//  nommit
//
//  Created by Jarred Sumner on 10/2/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#define DEVELOPMENT_URL @"http://localhost:3000"
#define DEVELOPMENT_STRIPE_KEY @"pk_test_evT0Hl8iSqKRXKkOvjJfPsKt"

#define PRODUCTION_URL @"http://www.getnommit.com"
#define PRODUCTION_STRIPE_KEY @"pk_live_lLUJxo6DJJiHvuCwFtxPlYmS"

#define PRODUCTION

#ifdef DEVELOPMENT
    #define API_URL DEVELOPMENT_URL
    #define STRIPE_KEY DEVELOPMENT_STRIPE_KEY
#else
    #define API_URL PRODUCTION_URL
    #define STRIPE_KEY DEVELOPMENT_STRIPE_KEY
//#define STRIPE_KEY PRODUCTION_STRIPE_KEY
#endif
