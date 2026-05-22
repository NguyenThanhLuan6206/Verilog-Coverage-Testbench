#!/bin/csh

# Generate test results report
# Summarizes all test logs and creates a summary table

set log = "rep.log"
if (-f $log) then
    rm -rf $log
endif

touch $log

@ count = 0
@ total = 0
@ remain = 0

printf "|-----------------------------------------------------------------------------------------------|\n" >> $log
printf "|%-40s |%-30s |%-20s |\n" " PAT_NAME" " RUN_DATE" " RESULT"                                             >> $log
printf "|-----------------------------------------------------------------------------------------------|\n" >> $log

foreach pat (`cat pat.list | sed '\/\//d'`)
    echo "Processing: $pat"
    set sim_log = "log/${pat}.log"
    set res = "NA"
    set tm = "NA"
    
    if( !(-f $sim_log)) then
        echo "Warning: cannot find $sim_log"
        set res = "NOT RUN"
    else
        # Extract timestamp
        set tm = `grep "End time" $sim_log | awk -F"[ :,]" '{print $5 ":" $6 ":" $7 " " $9 " " $10 " " $11}'`
        
        # Count PASS/FAIL in log
        set pass_count = `grep -c "PASS" $sim_log`
        set fail_count = `grep -c "FAIL" $sim_log`
        
        if( $fail_count > 0 ) then
            set res = "FAILED"
        else if( $pass_count > 0 ) then
            set res = "PASSED"
        else
            set res = "NO TEST"
        endif
    endif
    
    printf "|%-40s |%-30s |%-20s |\n" " $pat" " $tm" " $res"                                             >> $log
    printf "|-----------------------------------------------------------------------------------------------|\n" >> $log
    
    if( $res == "PASSED" ) then
        @ count++
    endif

    @ total++
end

set remain = `expr $total \- $count`

printf "\n" >> $log
printf "SUMMARY: TOTAL=%d / PASSED=%d / FAILED=%d\n" $total $count $remain >> $log

echo ""
cat $log
