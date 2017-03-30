//
//  ViewController.m
//  mysql
//
//  Created by apple  on 2017/3/30.
//  Copyright © 2017年 apple . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //  mysql --mac 启动配置
    
    /*
     
     sudo /usr/local/mysql/support-files/mysql.server start
     停止：
     
     sudo /usr/local/mysql/support-files/mysql.server stop
     还是比较麻烦，可以简化一下：在~/.bash_aliases中添加这样的命令：
     
     alias mysqlstart='sudo /usr/local/mysql/support-files/mysql.server start'
     alias mysqlstop='sudo /usr/local/mysql/support-files/mysql.server stop'
     
     如果没有.bash_aliases文件，可以创建一个，并在.bash_profile文件的最后加上这样的代码：
     if [ -f ~/.bash_aliases ]; then
     . ~/.bash_aliases
     fi
     
     参考：
     osx - start mySQL server from command line on Mac OS Lion - Stack Overflow
     http://stackoverflow.com/questions/7927854/start-mysql-server-from-command-line-on-mac-os-lion
     
     bashrc bash_profile bash_aliases | Bash | SS64.com
     https://ss64.com/bash/syntax-bashrc.html
     
     
     
     
     
     
     
     
     
     
     
     */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
