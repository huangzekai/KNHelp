//
//  KNLongLink.m
//  
//  长链
//  Created by kennyhuang on 16/5/18.
//  Copyright © 2016年 KN. All rights reserved.
//

#import "KNLongLink.h"
#import "AsyncSocket.h"
#import "KNHelp.h"

#define kDefault_TimeOut -1
#define kRead_Timeout -1
#define kWrite_TimeOut -1
#define KDefaultNoopTime 270
#define NOOP_CMDID_REQ (1009)
#define NOOP_CMDID_RESP (1000001009)

#define MAX_BUFFER 1024*64


#pragma mark - 长链

@interface KNLongLink ()<AsyncSocketDelegate>
{
    @private
    BOOL _syncOk;
}
@property (nonatomic, strong) AsyncSocket *socket;
@property (nonatomic, strong) NSTimer *noopingTimer;
@property (nonatomic, strong) NSMutableData *resultData;

@end

@implementation KNLongLink

#pragma mark - KNLongLink_DESCRIPTION

- (NSString *)connectStateDesciption
{
    NSString *text = nil;
    switch (self.state)
    {
        case EKNConnectIdle:
            text = @"connectIdle";
            break;
        case EKNConnecting:
            text = @"connecting";
            break;
        case EKNConnected:
            text = @"connected";
            break;
        case EKNDisConnecting:
            text = @"disconnecting";
            break;
        case EKNDisConnected:
            text = @"disconnected";
            break;
        case EKNConnectFailed:
            text = @"connectFailed";
            break;
        default:
            break;
    }
    return text;
}

- (void)dealloc
{
    _host = nil;
    _port = 0;
    [self.noopingTimer invalidate];
    self.noopingTimer = nil;
    
    [self.socket disconnect];
    self.socket = nil;
    
    DDLogInfo(@"KNLong link dealloc %p", self);
}

- (instancetype)initWithHost:(NSString *)host andPort:(NSUInteger)port
{
    self = [super init];
    if (self) {
        _host = host;
        _port = port;
        
        _resultData = [[NSMutableData alloc] init];
    }
    return self;
}

- (BOOL)isSyncOK
{
    return _syncOk;
}

- (void)changeState:(EKNLongLinkState)state
{
    if (state == self.state)
        return;
    
    self.state = state;
    DDLogInfo(@"KNLong link change to state:%@", [self connectStateDesciption]);
    
    if ([self.delegate respondsToSelector:@selector(longLink:changeConnectState:)]) {
        [self.delegate longLink:self changeConnectState:state];
    }
}

- (BOOL)connect
{
    if (EKNConnected == self.state) {
        return YES;
    }
//    [self performSelector:@selector(connectCometServer) withObject:nil];
    return [self connectCometServer];
}

- (BOOL)connectCometServer
{
    DDLogInfo(@"KNLong link connecting to server<%@:%ld>", self.host, self.port);
    
    if (!self.socket)
    {
        [self changeState:EKNConnecting];
        NSError *retError = nil;
        AsyncSocket *socket = [[AsyncSocket alloc] initWithDelegate:self];
        
        @try {
            BOOL retCode = [socket connectToHost:self.host onPort:self.port withTimeout:kDefault_TimeOut error:&retError];
            if (!retCode || nil != retError)
            {
                DDLogError(@"KNLong link connect error:%@\n", [retError description]);
                return NO;
            }
        }
        @catch (NSException *exception) {
            NSString *desc = [NSString stringWithFormat:@"<%@,%@>", exception.name, exception.reason];
            DDLogError(@"KNLong link connect exception:%@", desc);
            return NO;
        }
        self.socket = socket;
    }
    else
    {
        if (self.state == EKNConnected || self.state == EKNConnecting)
        {
            return YES;
        }
        self.socket.delegate = self;
        NSError *retError = nil;
        @try {
            [self changeState:EKNConnecting];
            BOOL retCode = [self.socket connectToHost:self.host onPort:self.port withTimeout:kDefault_TimeOut error:&retError];
            if (!retCode || nil != retError)
            {
                DDLogError(@"KNLong link connect error:%@\n", [retError description]);
                return NO;
            }
        }
        @catch (NSException *exception) {
            NSString *desc = [NSString stringWithFormat:@"<%@,%@>", exception.name, exception.reason];
            DDLogError(@"KNLong link connect exception:%@", desc);
            return NO;
        }
    }
    
    return YES;
}

-(void)cutOffSocket
{
    [self disconnect];
}

- (void)disconnect
{
    [self changeState:EKNDisConnecting];
    [self cancelNoopingRequest];
    
    if (nil != self.socket) {
        [self.socket disconnect];
    }
    
    [self changeState:EKNDisConnected];
}

- (void)nextNoopingRequest
{
    if (nil == self.noopingTimer)
    {
        self.noopingTimer = [NSTimer timerWithTimeInterval:KDefaultNoopTime
                                                           target:self selector:@selector(noopingRequest)
                                                         userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.noopingTimer forMode:NSDefaultRunLoopMode];
}

- (void)cancelNoopingRequest
{
    if (nil == self.noopingTimer)
        return;
    
    [self.noopingTimer invalidate];
    self.noopingTimer = nil;
}

- (BOOL)noopingRequest
{
    return NO;
}

- (unsigned int)sendNoopingData
{
//    if (EKNConnected != self.state)
        return -1;
    
//    return [self sendMessage:nil];
}

///发送消息
- (void)sendMessage:(NSData *)data
{
    DDLogInfo(@"KNLong link send data with length:%ld", data.length);
    [self.socket writeData:data withTimeout:kWrite_TimeOut tag:-1];
}

#pragma mark - AsyncSocketDelegate

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    
    if (![sock isEqual:self.socket])
        return;
    
    [self clearResultData];
    
    [self changeState:EKNDisConnecting];
    DDLogInfo(@"KNLong link socket will disconnect");
    
    if (nil != err) {
        DDLogError(@"KNLong link socket will disconnect with error:%@\n", [err description]);
    }
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    if (![sock isEqual:self.socket])
        return;
    
    [self clearResultData];
    [self changeState:EKNDisConnected];
    DDLogInfo(@"KNLong link socket didDisconnect");
    
    [self disconnect];
}

- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port {
    if (![sock isEqual:self.socket])
        return;
    [self changeState:EKNConnected];
    NSLog(@"KNLong link socket didConnectTo<%@,%d>", host, port);
    DDLogInfo(@"KNLong link socket didConnectTo<%@,%d>", host, port);
    [self.socket readDataWithTimeout:kDefault_TimeOut tag:0];
    [self nextNoopingRequest];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [self.socket readDataWithTimeout:kRead_Timeout buffer:nil bufferOffset:0 maxLength:MAX_BUFFER tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    if (![sock isEqual:self.socket])
        return;
    
    DDLogInfo(@"KNLong link did receive data length:%ld", data.length);
    @try {
//        ErrCmdType errtype = ectOK;
//        int errcode = 0;
//        unsigned int seq = INVALID_SEQ;
//        [self parseResponseData:data errorType:errtype errorCode:errcode seq:seq];
//        
//        if (ectOK != errtype)
//        {
//            [self onResponseErrorWithType:errtype errorCode:errcode seq:seq];
//        }
    }
    @catch (NSException *exception) {
        
        NSString *desc = [NSString stringWithFormat:@"<%@,%@>", exception.name, exception.reason];
        DDLogError(@"KNLong link read data exception:%@", desc);
    }
}

#pragma mark - 回包

//- (void)parseResponseData:(NSData *)response errorType:(ErrCmdType&)errtype errorCode:(int&)errcode seq:(unsigned int &)seq
//{
//    
//    [self.resultData appendData:response];
//    
//    AutoBuffer bufrecv;
//    bufrecv.Write([self.resultData bytes], self.resultData.length);
//
//    while (0 < bufrecv.Length())
//    {
//        int cmdid = 0;
//        unsigned int packlen = 0;
//        AutoBuffer body;
//        
//        int unpackret = unmakenetmsgxp(bufrecv, cmdid, seq, packlen, body);
//        if (MSGXP_FALSE == unpackret)
//        {
//            DDLogError(@"long link unpack error length:%ld", bufrecv.Length());
//            errtype = ectNetMsgXP;
//            errcode = ectNetMsgXP_HandleBufferErr;
//            
//            [self clearResultData];
//            
//            return;
//        }
//        
//        NSString *recvFlag = (MSGXP_CONTINUE == unpackret) ? @"continue" : @"finish";
//        DDLogInfo(@"long link pack recv %@, seq:%d, cmdid:%d, recvlen:%d, packlen:%zu", recvFlag, seq, cmdid, self.resultData.length, bufrecv.Length(), packlen);
//        
//        if (MSGXP_CONTINUE == unpackret) //服务器端还有后续数据发送
//        {
//            [self.socket readDataWithTimeout:kRead_Timeout tag:0];
//            DDLogInfo(@"long link :服务器还有后续数据 seq:%d,cmdid:%d,recvlen:%d",seq,cmdid,self.resultData.length);
//            break;
//        }
//        else
//        {
//
//            long moveLenght = bufrecv.Move(-(int)(packlen));
//            
//            if (moveLenght == 0) { //为0的时候意味着包是完整的，可以把数据清除了
//                [self clearResultData];
//            }
//            DDLogInfo(@"moveToLenght:%ld",moveLenght);
//            if ([self noopingResponse:cmdid seq:seq buffer:body])
//            {
//                DDLogInfo(@"nooping response span");
////                xdebug("noopresp span:%0", gettickspan(nooping_timeout));
////                nooping_timeout = 0;
//            } else {
//                DDLogInfo(@"nooping response");
//            
//                OnLongLinkResponse(seq, cmdid, body);
//                
//                NSData *responseData = [CRequest2OC dataForHexForChar:(unsigned char*)body.Ptr() len:body.Length()];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if ([self.delegate respondsToSelector:@selector(longLink:responseData:commonId:)]) {
//                        [self.delegate longLink:nil responseData:responseData commonId:cmdid];
//                    }
//                });
//            }
//        }
//    }
//}

//- (NSTimeInterval)onSocket:(AsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag
//                   elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length
//{
//    DDLogInfo(@"KNLong link read timeout with tag:%ld", tag);
//    return 30;
//}

//void OnLongLinkResponse(int anSeq, int anCmdID, const AutoBuffer& buf)
//{
//    
//    xinfo2_if(0==anSeq || -1==anSeq, TSF"notinfy seq:%_, cmdid:%_, len:%_", anSeq, anCmdID, buf.Length());
//    
//    onNotify(anSeq, anCmdID, buf);
//}
//
//- (BOOL)noopingResponse:(int)cmdid seq:(int)seq buffer:(AutoBuffer &)buf
//{
//    bool isNoop = false;
//    if (m_identifychecker.IsIdentifyResp(seq, cmdid))
//    {
//        DDLogInfo(@"KNLong link end nooping synccheck");
//        _syncOk = true;
//        isNoop = true;
//        m_identifychecker.OnIdentifyResp(buf);
//    }
//    
//    if (cmdid == NOOP_CMDID_RESP)
//    {
//        DDLogInfo(@"KNLong link end nooping");
//        _syncOk = true;
//        isNoop = true;
//        ::onRequestDoSync();
//    }
//    
//    return isNoop;
//}
//
//- (void)onResponseErrorWithType:(ErrCmdType)type errorCode:(int)code seq:(unsigned int)seq
//{
//    DDLogError(@"KNLong link response with errorType:%d, code:%d", type, code);
//    
//    if ([self.delegate respondsToSelector:@selector(longLink:reportErrorWithType:errorCode:seq:)])
//    {
//        [self.delegate longLink:self reportErrorWithType:type errorCode:code seq:seq];
//    }
//}


- (void)clearResultData
{
    [self.resultData resetBytesInRange:NSMakeRange(0, self.resultData.length)];
    [self.resultData setLength:0];
}

@end
