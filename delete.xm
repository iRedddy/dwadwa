%hook UIApplication
-(void)finishedTest:(id)arg1 extraResults:(id)arg2 {

    %orig;

    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(Delete) userInfo:nil repeats:YES];

}

 %new
-(void) Delete {


[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/Documents/ano_tmp",NSHomeDirectory()] error:nil];

[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()] error:nil];

[[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/tmp",NSHomeDirectory()] error:nil];


}

%end

