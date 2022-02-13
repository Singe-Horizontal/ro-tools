#!/bin/awk -f

BEGIN{    
    hp_job_a["Hunter"]=0.85;
    hp_job_a["Assassin"]=1.1;
    hp_job_a["Priest"]=0.75;
    hp_job_a["Blacksmith"]=0.9;
    hp_job_a["Wizard"]=0.55;
    hp_job_a["TaeKwon Master"]=0.9;
    hp_job_a["Crusader"]=1.1;
    hp_job_a["Dancer/Bard"]=0.75;
    hp_job_a["Rogue"]=0.85;
    hp_job_a["Monk"]=0.9;
    hp_job_a["Alchemist"]=0.9;
    hp_job_a["Sage"]=0.75;
    hp_job_a["Soul Linker"]=0.75;
    hp_job_a["Knight"]=1.5;
    
    hp_job_b["TaeKwon Master"]=6.5;
    hp_job_b["Crusader"]=7;
    hp_job_b["Monk"]=6.5;
    hp_job_b["DEFAULT"]=5;
    if(ARGV[1]>0)
	max_level=ARGV[1];
    else
	max_level=99;

    print "Header:";
    print "  Type: JOB_STATS";
    print "  Version: 1";
    print "Body:";

    for(job in hp_job_a){
	print "  - Jobs:";
	print "      "job": true"
	print "    BaseHp:";
	for(base_level = 1; base_level <= max_level; ++base_level){
	    base_hp = 35;
	    if(hp_job_b[job])
		base_hp += base_level * hp_job_b[job];
	    else
		base_hp += base_level * 5;

	    for (i = 2; i <= base_level; i++) {
		if(hp_job_a[job]){
		    base_hp += round(hp_job_a[job] * i);
		}
	    }
	    print "      - Level: "base_level;
	    print "        Hp: "base_hp;

	}
    }
}

function round(x,   ival, aval, fraction){
    ival = int(x)    # integer part, int() truncates

    # see if fractional part
    if (ival == x)   # no fraction
	return ival   # ensure no decimals

    if (x < 0) {
	aval = -x     # absolute value
	ival = int(aval)
	fraction = aval - ival
	if (fraction >= .5)
	    return int(x) - 1   # -2.5 --> -3
	else
	    return int(x)       # -2.3 --> -2
    } else {
	fraction = x - ival
	if (fraction >= .5)
	    return ival + 1
	else
	    return ival
    }
}
