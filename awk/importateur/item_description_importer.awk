#!/bin/gawk -f

#This program will import lines from file 2 between ]re_start,re_end[ into file 1
BEGIN {
    re_id=@/^[\t ]*\[([0-9]+)\].*/
    re_start=@/identifiedResourceName/
    re_end=@/DisplayName|slotCount/
    file_to_import_from=ARGV[2]
    import_id=0
}
{
    print $0
    #This first section's goal is to match the IDs from inputs
    while (getline line > 0) {
	if(line ~ re_id){
 	    id= 0+gensub(re_id,"\\1","G",line)
	    if(id < import_id )
		continue
	    
	    while(import_id < id && (getline new_line < file_to_import_from) > 0 ){
		if(new_line ~ re_id){		    
		    import_id= 0+gensub(re_id,"\\1","g",new_line)
		}
	    }
	}
	if(import_id > id) # New file_to_import_from id can be suddently greater ex: In previous loop num was 400, iNum was 398, 399, and suddently 401
	    continue
	
	#From here we are confident that IDs are matching, thus we can proceed into printing
	
	print line #  print all lines until re_start included 
	if(line ~ re_start){ 
	    
	    while( (getline new_line < file_to_import_from) >0 && new_line !~ re_start ){}
	    #Align imported file on re_start
	    
	    while( (getline new_line < file_to_import_from) > 0 && new_line !~ re_end)
		print new_line

       	    while(getline line > 0 &&  line !~ re_end ){}
	    #Align main file on re_end
	    
 	    print line # Print post re_end line in original language.
	}
    }    
}
ENDFILE{
    delete ARGV[2] # Don't loop through imported file after main file is done
} 
