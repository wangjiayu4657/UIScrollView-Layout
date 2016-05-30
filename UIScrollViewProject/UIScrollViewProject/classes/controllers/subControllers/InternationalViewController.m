//
//  InternationalViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/30.
//  Copyright © 2016年 fangjs. All rights reserved.

/**  UIScrollView 的悬停效果  **/



#import "InternationalViewController.h"

@interface InternationalViewController ()<UIScrollViewDelegate>

/**redView*/
@property (weak , nonatomic) UIView *redView;
/**imageView*/
@property (weak , nonatomic) UIImageView *imageView;

@end


@implementation InternationalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    imageView.image = [UIImage imageNamed:@"ad_00"];
    self.imageView = imageView;
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, ScreenWidth, 44)];
    redView.backgroundColor = [UIColor redColor];
    self.redView = redView;
    
    UIView *otherView = [[UIView alloc] initWithFrame:CGRectMake(0, 184, ScreenWidth, 600)];
    otherView.backgroundColor = [UIColor magentaColor];
    
    scroll.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(otherView.frame));
    
    [scroll addSubview:imageView];
    [scroll addSubview:redView];
    [scroll addSubview:otherView];
    
    [self.view addSubview:scroll];

}



- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    CGFloat offsetY = offset.y / 70;
    CGFloat scale = 1 - offsetY;
    
    scale = (scale > 1)? scale : 1;
    self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    if (offset.y > 140) {
        self.redView.frame = CGRectMake(0, 0, ScreenWidth, 44);
        [self.view addSubview:self.redView];
    }else {
        self.redView.frame = CGRectMake(0, 140, ScreenWidth, 44);
        [scrollView addSubview:self.redView];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 20;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *cellID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    cell.textLabel.text = [NSString stringWithFormat:@"cell--%zd",indexPath.row];
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
