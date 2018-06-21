//
//  ViewController.m
//  GitHub Repos
//
//  Created by Will Chew on 2018-06-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "ViewController.h"
#import "RepoNameCellTableViewCell.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *namesTableView;
@property (nonatomic,strong) NSMutableArray *repoArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/WillChew/repos"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        NSError *jsonError = nil;
        NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"error: %@", jsonError.localizedDescription);
            return;
        }
        
        //if we reach this point, we've successfully retrieved the JSON from the API
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        
        
        
        for (NSDictionary *repo in repos) {
            NSString *repoNames = repo[@"name"];
            

            [mutableArray addObject:repoNames];
            self.repo = [[Repo alloc]initWithDictionary:repo];
            
        }
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.namesTableView reloadData];
            
            
        }];
        self.repoArray = mutableArray;
        
    }];
    
    [dataTask resume];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repoArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RepoNameCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoNameCell"];
    
    cell.repoNamesLabel.text = self.repoArray[indexPath.row];
    NSLog(@"repos : %@", self.repo);
    
    return cell;
}


@end
