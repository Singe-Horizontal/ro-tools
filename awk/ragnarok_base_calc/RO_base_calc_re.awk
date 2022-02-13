#!/bin/awk -f
#Copyright © 2022 Singe-Horizontal
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



BEGIN{
    duplicate["Novice"]="Novice_High Baby Baby"
    duplicate["Supernovice"]="Super_Baby Super_Novice_E Super_Baby_E"
    duplicate["Swordman"]="Swordman_High Baby_Swordman"
    duplicate["Archer"]="Archer_High Baby_Archer"
    duplicate["Thief"]="Thief_High Baby_Thief"
    duplicate["Acolyte"]="Acolyte_High Baby_Acolyte"
    duplicate["Merchant"]="Merchant_High Baby_Merchant"
    duplicate["Mage"]="Mage_High Baby_Mage"
    duplicate["Knight"]="Knight2 Lord_Knight Lord_Knight2 Baby_Knight Baby_Knight2"    
    duplicate["Hunter"]="Sniper Baby_Hunter"    
    duplicate["Assassin"]="Assassin_Cross Baby_Assassin"
    duplicate["Priest"]="High_Priest Baby_Priest"
    duplicate["Blacksmith"]="Whitesmith Baby_Blacksmith"
    duplicate["Wizard"]="High_Wizard Baby_Wizard"    
    duplicate["Crusader"]="Crusader2 Paladin Paladin2 Baby_Crusader Baby_Crusader2"
    duplicate["Bard"]="Clown Baby_Bard"
    duplicate["Dancer"]="Gypsy Baby_Dancer"    
    duplicate["Rogue"]="Stalker Baby_Rogue"
    duplicate["Monk"]="Champion Baby_Monk"    
    duplicate["Alchemist"]="Creator Baby_Alchemist"
    duplicate["Sage"]="Professor Baby_Sage"
    duplicate["Star_Gladiator"]="Star_Gladiator2"
    
    hp_job_a["Novice"]=0;
    hp_job_a["Supernovice"]=0;
    hp_job_a["Swordman"]=0.7;
    hp_job_a["Archer"]=0.5;
    hp_job_a["Thief"]=0.5;
    hp_job_a["Acolyte"]=0.4;
    hp_job_a["Merchant"]=0.4;
    hp_job_a["Mage"]=0.3;
    hp_job_a["Taekwon"]=0.7;
    hp_job_a["Ninja"]=0.75;
    hp_job_a["Gunslinger"]=0.9;
    hp_job_a["Knight"]=1.5;    
    hp_job_a["Hunter"]=0.85;
    hp_job_a["Assassin"]=1.1;
    hp_job_a["Priest"]=0.75;
    hp_job_a["Blacksmith"]=0.9;
    hp_job_a["Wizard"]=0.55;
    hp_job_a["Crusader"]=1.1;
    hp_job_a["Bard"]=0.75;    
    hp_job_a["Dancer"]=0.75;
    hp_job_a["Rogue"]=0.85;
    hp_job_a["Monk"]=0.9;
    hp_job_a["Alchemist"]=0.9;
    hp_job_a["Sage"]=0.75;
    hp_job_a["Star_Gladiator"]=0.9;    
    hp_job_a["Soul_Linker"]=0.75;

##    
    hp_job_b["Star_Gladiator"]=6.5;
    hp_job_b["Crusader"]=7;
    hp_job_b["Monk"]=6.5;
    hp_job_b["DEFAULT"]=5;
####SP####    
    sp_job["Novice"]=1;
    sp_job["Super Novice"]=1;
    sp_job["Swordman"]=2;
    sp_job["Archer"]=2;
    sp_job["Thief"]=2;
    sp_job["Acolyte"]=5;
    sp_job["Merchant"]=3;
    sp_job["Mage"]=6;
    sp_job["Taekwon Kid"]=2;
    sp_job["Ninja"]=3;
    sp_job["Gunslinger"]=4;
    sp_job["Knight"]=3;
    sp_job["Hunter"]=4;
    sp_job["Assassin"]=4;
    sp_job["Priest"]=8;
    sp_job["Blacksmith"]=4;
    sp_job["Wizard"]=9;
    sp_job["Crusader"]=4.7;
    sp_job["Bard"]=6;
    sp_job["Dancer"]=6;    
    sp_job["Rogue"]=5;
    sp_job["Monk"]=4.7;
    sp_job["Alchemist"]=4;
    sp_job["Sage"]=7;
    sp_job["Star_Gladiator"]=4;    
    sp_job["Soul_Linker"]=9;
    
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
	split(duplicate[job],dups," ");
	for(dup in dups)
	    print "      "dups[dup]": true";
	
	print "    BaseHp:";
	for(base_level = 1; base_level <= max_level; ++base_level){
	    base_hp = 35;
	    if(job in hp_job_b)
		base_hp += base_level * hp_job_b[job];
	    else
		base_hp += base_level * hp_job_b["DEFAULT"];

	    for (i = 2; i <= base_level; i++) {
		if(hp_job_a[job]){
		    base_hp += round(hp_job_a[job] * i);
		}
	    }
	    print "      - Level: "base_level;
	    print "        Hp: "base_hp;

	}
    }
    for(job in sp_job){
	print "  - Jobs:";
	print "      "job": true"
	split(duplicate[job],dups," ");
	for(dup in dups)
	    print "      "dups[dup]": true";
	print "    BaseSp:";
	for(base_level = 1; base_level <= max_level; ++base_level){
	    base_sp = 10;
	    base_sp += base_level * sp_job[job];
	    print "      - Level: "base_level;
	    print "        Sp: "base_sp;

	}
    }
}

function round(x,ival, aval, fraction){
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
