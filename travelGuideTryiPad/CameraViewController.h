//
//  CameraViewController.h
//  travelGuideTryiPad
//
//  Created by Felipe Arturo Pérez Camargo on 12/03/14.
//  Copyright (c) 2014 Felipe Arturo Pérez Camargo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImage *chosenImage;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

-(IBAction)takePhoto;
-(IBAction)selectPhoto;
-(IBAction)facebook;
-(IBAction)twitter;


@end
