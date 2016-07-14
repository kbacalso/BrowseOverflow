//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by taki bacalso on 06/07/2016.
//  Copyright © 2016 Taki. All rights reserved.
//

#import "StackOverflowCommunicator.h"

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";

@implementation StackOverflowCommunicator

- (void)dealloc
{
    [fetchingConnection cancel];
}

- (void)launchConnectionForRequest:(NSURLRequest *)request
{
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request
                                                       delegate:self];
}

- (void)fetchContentAtURL:(NSURL *)url
             errorHandler:(void (^)(NSError *))errorBlock
           successHandler:(void (^)(NSString *))successBlock
{
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    
    [self launchConnectionForRequest:request];
}

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?site=stackoverflow&tagged=%@&pagesize=120", tag];
    [self fetchContentAtURL:[NSURL URLWithString:urlString]
               errorHandler:^(NSError *error) {
                   
                   [self.delegate searchingForQuestionsFailedWithError:error];
                   
               } successHandler:^(NSString *objectNotation) {
                   
                   [self.delegate receivedQuestionsJSON:objectNotation];
                   
               }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = nil;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain:StackOverflowCommunicatorErrorDomain
                                             code:[httpResponse statusCode]
                                         userInfo:nil];
        
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
        
        return;
    }
    
    receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    fetchingConnection = nil;
    fetchingURL = nil;
  
    NSString *receivedText = [[NSString alloc] initWithData:receivedData
                                                   encoding:NSUTF8StringEncoding];
    
    receivedData = nil;
    successHandler(receivedText);
}

- (void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%ld?order=desc&sort=activity&site=stackoverflow&filter=withbody", identifier];
    [self fetchContentAtURL:[NSURL URLWithString:urlString]
               errorHandler:^(NSError *error) {
                   
                   // handle error
                   
               } successHandler:^(NSString *objectNotation) {
                   
                   // handle success
                   
               }];
                             
}

- (void)downloadAnswersToQuestionID:(NSInteger)identifier
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%ld/answers?site=stackoverflow&filter=withbody", identifier];
    [self fetchContentAtURL:[NSURL URLWithString:urlString]
               errorHandler:^(NSError *error) {
                   
                   // error
                   
               } successHandler:^(NSString *objectNotation) {
                   
                   // handle success
                   
               }];
}


@end
