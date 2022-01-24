#!/bin/gawk -f
BEGIN {
    re_id=@/[\t ]+\[[0-9]+\]/
    re_start=@/identifiedResourceName/
    re_end=@/DisplayName|slotCount/
}
{
    print $0 #tbl

    #This first section's goal is to match the IDs from inputs
    while (getline line > 0) {
	if(line ~ re_id){
	    split(line,num,"[")
	    split(num[2],num,"]") #extract the number
#debug#	        print " num[1] : "num[1]" iNum[1] : "iNum[1] #debug
	    
	    if(0+iNum[1] >0+ num[1])
		continue
	    
	    while( (0+iNum[1])<(0+num[1]) && (getline imported_line < ARGV[2]) > 0 ){# && imported_line !~ re_id ){
		if(imported_line ~ re_id){		    
		    split(imported_line,iNum,"[")
		    split(iNum[2],iNum,"]")
#debug#		       print " num[1] : "num[1]" iNum[1] : "iNum[1] #debug
		}
	    }
	}
	if(0+iNum[1] > 0+num[1]) # New imported_file id can be suddently greater ex: In previous loop num was 400, iNum was 398, 399, and suddently 401
	    continue
	
	#From here we are now sure that IDs are matched, we can proceed into printing
	
#debug#	print line" "num[1]" "iNum[1] " #debug
	print line
	if(line ~ re_start){
	    while( imported_line !~ re_start && (getline imported_line < ARGV[2]) >0 )
		; # ; needed in order to align imported file on same field
	    
	    while( line !~ re_end && (getline line) > 0)
	     	; # ; to align main file on end field
	    
	    while( (getline imported_line < ARGV[2]) > 0 && imported_line !~ re_end)
		print imported_line
 	    print line #not easy logic on those lines...need to rethink about it 
	}
    }    
}

ENDFILE{
    delete ARGV[2] # Don't loop through imported file after main file is done
} 
