

@import Nodelike;

//#import "NLContext.h"

#import <UIKit/UIKit.h>

#import <JavaScriptCore/JavaScriptCore.h>


@interface NLAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>
{
    NSString *scriptToLoad;
}
@property (strong, nonatomic) UIWindow *window;
@end

@implementation NLAppDelegate

- (BOOL)application:(UIApplication*)a     openURL:(NSURL*)url
  sourceApplication:(NSString*)sourceA annotation:ann {

    NSString *script = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    if (script) {
        
        scriptToLoad = script;

        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Open File"
                              message:@"You are about to load a file into the editor. This will clear your current script."
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK",
                              nil];
        [alert show];

    }

    return YES;
}

- (void)alertView:(UIAlertView *)a didDismissWithButtonIndex:(NSInteger)b {

    if ([[a buttonTitleAtIndex:b] isEqualToString:@"OK"])
        [NSNotificationCenter.defaultCenter postNotificationName:@"NLFileOpen" object:nil userInfo:@{@"script": scriptToLoad}];
}

@end


int main(int c, char * v[]) {

    @autoreleasepool {
        return UIApplicationMain(c,v,nil,NSStringFromClass(NLAppDelegate.class));
    }
}
