//
//  KNGlobalDefine.h
//  KNHelp
//
//  Created by kennykhuang on 2017/4/20.
//  Copyright © 2017年 KennyHuang. All rights reserved.
//

#ifndef KNGlobalDefine_h
#define KNGlobalDefine_h

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelError;
#endif

#endif /* KNGlobalDefine_h */
