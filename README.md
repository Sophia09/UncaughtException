UncaughtException
=================

project code for iOS recipes

Purpose: write uncaughtException info to a file, so app users can send that file to us.
Steps:
    1. using NSSetUncaughtExceptionHandler to register a handler in appDidFinishLaunch:withOptions;
        NSSetUncaughtExceptionHandler(&myExceptionHandler);
        
    2. redirect stderr output from console to file
        (If uncaughtExcetion occured before, redirect stderr after the user send log file, since we use  "w" mode to recreate a file);
        freopen(logfile, "w", stderr);
        
    3. when user reopens this app after an uncaughtExcetion, show an alert to advice user sending that file to developer(using email);
    
    
