
#import "NLMasterViewController.h"

#import "NLEditorViewController.h"
#import "NLConsoleViewController.h"

#import "CSNotificationView.h"
#import "PBWebViewController.h"

#import "NLColor.h"

@import Nodelike;


@implementation NLMasterViewController

- (void)viewDidLoad
{

  [super viewDidLoad];
  self.viewControllers = @[
    _editorViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editorViewController"],
    _consoleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"consoleViewController"]
  ];

  [self pushViewController:
    _documentationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"documentationViewController"]];


  [self setupStyle];

  self.node = Nodelike.new;
  
//  __weak NLMasterViewController *weakSelf = self;
//
//  [NLContext attachToContext:_context = [NLContext.alloc initWithVirtualMachine:JSVirtualMachine.new]];
//
//  _context.exceptionHandler = ^(JSContext *c, JSValue *e) {
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//      [weakSelf error:[e toString]];
//      NSLog(@"%@ stack: %@", e, [e valueForProperty:@"stack"]);
//    });
//  };
//
//  id logger = ^(JSValue *thing) {
//
//    for (id obj in JSContext.currentArguments) {
//
//      NSLog(@"log: %@", [obj toString]);
//      [((NLConsoleViewController *)self.consoleViewController) log:[obj toString]];
//    }
//  };
//  _context[@"console"] = @{@"log": logger, @"error": logger};
//
//  [_context evaluateScript:@"process.env['NODE_DEBUG']='module'"];

}

- (void)setupStyle {

  //self.navigationController.navigationBar.tintColor    = [NLColor greenColor];
  //self.navigationController.navigationBar.barTintColor = [NLColor blackColor];
  self.navigationController.toolbar.tintColor          = [NLColor blackColor];
  self.navigationController.toolbar.barTintColor       = [[NLColor whiteColor] colorWithAlphaComponent:0.5];

}

- (void)executeJS:(NSString *)code {

  [self output:[_node executeJS:code]];

//  JSValue *ret = [_context evaluateScript:code];
//
//  if (![ret isUndefined]) [self output:[ret toString]];
//
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//    self.backgroundTask = [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler:^{
//      NSLog(@"beginBG called");
//      [UIApplication.sharedApplication endBackgroundTask:self.backgroundTask];
//      self.backgroundTask = UIBackgroundTaskInvalid;
//    }];
//
//    [NLContext runEventLoopSync];
//
//    [UIApplication.sharedApplication endBackgroundTask:self.backgroundTask];
//    self.backgroundTask = UIBackgroundTaskInvalid;
//
//  });

}

- (void)output:(NSString *)message {
  //    [CSNotificationView showInViewController:self
  //                                       style:CSNotificationViewStyleSuccess
  //                                     message:message];
}

- (void)error:(NSString *)message {
  //    [CSNotificationView showInViewController:self
  //                                       style:CSNotificationViewStyleError
  //                                     message:message];
}

- (IBAction)execute:(id)sender {
  [self executeJS:((NLEditorViewController *)self.editorViewController).input.text];
}

- (IBAction)showInfo:(id)sender {

  PBWebViewController *docuViewController = PBWebViewController.new;
  docuViewController.URL = [NSURL URLWithString:@"http://nodeapp.org/?utm_source=interpreter&utm_medium=App&utm_campaign=info"];
  [self.navigationController pushViewController:docuViewController animated:YES];
}

@end
