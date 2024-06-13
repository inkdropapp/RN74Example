//
//  AttachmentProcessor.m
//  RN74Example
//
//  Created by Takuya Matsuyama on 2024/06/12.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AttachmentProcessor.h"
#import <React-Core/React/RCTBridgeProxy.h>
#import <React/RCTUIManager.h>
#import <React-RCTFabric/React/RCTSurfacePresenter.h>
#import <React-RCTFabric/React/RCTMountingManager.h>
#import <React-RCTFabric/React/RCTComponentViewRegistry.h>
#import <React-RuntimeApple/ReactCommon/RCTHost.h>
#import <React-RCTFabric/React/RCTViewComponentView.h>
#import <WebKit/WebKit.h>

@implementation AttachmentProcessor

@synthesize bridge = _bridge;

- (void)setBridge:(RCTBridge *)bridge
{
  _bridge = bridge;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

- (void)process:(double)tag resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  NSLog(@"react tag: %f", tag);
  
  AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  RCTHost *reactHost = (RCTHost*)[delegate.rootViewFactory valueForKey:@"_reactHost"];
  NSLog(@"reactHost? %@", reactHost);

  RCTComponentViewRegistry* viewRegistry = reactHost.surfacePresenter.mountingManager.componentViewRegistry;
  RCTViewComponentView *view = (RCTViewComponentView*)[viewRegistry findComponentViewWithTag:(int32_t)tag];
  NSLog(@"view: %@", view);
  WKWebView *webView = (WKWebView*)[view.contentView valueForKey:@"webView"];
  NSLog(@"webview: %@", webView);
  [webView evaluateJavaScript:@"alert('hello')" completionHandler:nil];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeAttachmentProcessorSpecJSI>(params);
}
#endif

@end
