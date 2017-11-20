//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "ViewController.h"

@import FirebasePerformance;

@interface ViewController()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSArray *paths = NSSearchPathForDirectoriesInDomains
  (NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentsDirectory = paths[0];

  //make a file name to write the data to using the documents directory
  NSString *fileName = [NSString stringWithFormat:@"%@/perfsamplelog.txt",
                        documentsDirectory];

  // Start tracing
  FIRTrace *trace = [FIRPerformance startTraceWithName:@"request_trace"];

  NSError *fileReadError;
  NSString *contents = [NSString stringWithContentsOfFile:fileName
                                                 encoding:NSUTF8StringEncoding
                                                    error:&fileReadError];

  if (fileReadError != nil) {
    NSLog(@"Log file doesn't exist yet %@: %@", fileName, fileReadError);
  }

  NSUInteger fileLength = 0;
  if (contents) {
    fileLength = contents.length;
  }

  [trace incrementCounterNamed:@"log_file_size" by:fileLength];

  NSString *target = @"https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png";
  NSURL *targetUrl = [NSURL URLWithString:target];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:targetUrl];
  request.HTTPMethod = @"GET";

  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
    ^(NSData * _Nullable data,
      NSURLResponse * _Nullable response,
      NSError * _Nullable error) {

      if (error) {
        NSLog(@"%@", error.localizedDescription);
      }

      dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = [UIImage imageWithData:data];
      });

      [trace stop];

      NSString *contentToWrite = [contents stringByAppendingString:response.URL.absoluteString];
      [contentToWrite writeToFile:fileName
                       atomically:NO
                         encoding:NSStringEncodingConversionAllowLossy
                            error:nil];
    }] resume];

  [trace incrementCounterNamed:@"request_sent"];
}

@end
