#!/bin/sh
#
# SCRIPT:	headline12c.sh
# AUTHOR:	thedzy <thedzy@hotmail.com>
# DATE:		2018-09-24
# REV:		12.0c
#
# PLATFORM: MacOS
#
# PURPOSE:
#	Print title/banner
#
# FUNCTIONS: 
#	headline()
# PARAMETERS: 
#	$@ Text to  print
#

headline () {
	# http://patorjk.com/software/taag/#p=testall&h=0&v=0&f=Modular&t=ABCDEFGHIJKLMNOPQRSTUVWXYZ
	
	WINCOLS=$(tput cols)
	WINROWS=$(tput lines)
	
	# Character sets
	LETTERSET=( '.' {A..Z} '!' ',' '?')
	LETTERHGT=10	#Average
	#LETTERWID  .  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z  !  ,
	LETTERWID=( 2  22 15 18 19 15 15 19 17 7 18 16 15 32 17 19 15 20 16 15 19 15 23 29 19 19 19  6  6 17 0) # height a and width of letters
	LETTERDES=(
		'           .8.          8 888888888o       ,o888888o.    8 888888888o.      8 8888888888   8 8888888888        ,o888888o.    8 8888        8  8 8888            8 8888 8 8888     ,88; 8 8888                  ,8.       ,8.          b.             8     ,o888888o.     8 888888888o       ,o888888o.      8 888888888o.      d888888o.   8888888 8888888888 8 8888      88 `8.`888b           ,8; `8.`888b                 ,8; `8.`8888.      ,8; `8.`8888.      ,8;  8888888888;,8888; 8 888           ;P88888`         '
		'          .888.         8 8888    `88.    8888     `88.  8 8888    `^888.   8 8888         8 8888             8888     `88.  8 8888        8  8 8888            8 8888 8 8888    ,88;  8 8888                 ,888.     ,888.         888o.          8  . 8888     `88.   8 8888    `88.  . 8888     `88.    8 8888    `88.   .`8888:; `88.       8 8888       8 8888      88  `8.`888b         ,8;   `8.`888b               ,8;   `8.`8888.    ,8;   `8.`8888.    ,8;          ,8;,8888;  8 888         ;88,   8888.       '
		'         :88888.        8 8888     `88 ,8 8888       `8. 8 8888        `88. 8 8888         8 8888          ,8 8888       `8. 8 8888        8  8 8888            8 8888 8 8888   ,88;   8 8888                .`8888.   .`8888.        Y88888o.       8 ,8 8888       `8b  8 8888     `88 ,8 8888       `8b   8 8888     `88   8.`8888.   Y8       8 8888       8 8888      88   `8.`888b       ,8;     `8.`888b             ,8;     `8.`8888.  ,8;     `8.`8888.  ,8;          ,8;,8888;   8 888        ;8.      8888 8`     '
		'        . `88888.       8 8888     ,88 88 8888           8 8888         `88 8 8888         8 8888          88 8888           8 8888        8  8 8888            8 8888 8 8888  ,88;    8 8888               ,8.`8888. ,8.`8888.       .`Y888888o.    8 88 8888        `8b 8 8888     ,88 88 8888        `8b  8 8888     ,88   `8.`8888.           8 8888       8 8888      88    `8.`888b     ,8;       `8.`888b     .b    ,8;       `8.`8888.,8;       `8.`8888.,8;          ,8;,8888;    8 888                 8888 8      '
		'       .8. `88888.      8 8888.   ,88; 88 8888           8 8888          88 8 888888888888 8 888888888888  88 8888           8 8888        8  8 8888            8 8888 8 8888 ,88;     8 8888              ,8;8.`8888,8^8.`8888.      8o. `Y888888o. 8 88 8888         88 8 8888.   ,88; 88 8888         88  8 8888.   ,88;    `8.`8888.          8 8888       8 8888      88     `8.`888b   ,8;         `8.`888b    88b  ,8;         `8.`88888;         `8.`88888;          ,8;,8888;     8 888               8888 88       '
		'      .8`8. `88888.     8 8888888888   88 8888           8 8888          88 8 8888         8 8888          88 8888           8 8888        8  8 8888            8 8888 8 8888 88;      8 8888             ,8; `8.`8888; `8.`8888.     8`Y8o. `Y88888o8 88 8888         88 8 888888888P;  88 8888     `8. 88  8 888888888P;      `8.`8888.         8 8888       8 8888      88      `8.`888b ,8;           `8.`888b .`888b,8;          .88.`8888.          `8. 8888          ,8;,8888;      8 888             8888 88         '
		'     .8; `8. `88888.    8 8888    `88. 88 8888           8 8888         ,88 8 8888         8 8888          88 8888   8888888 8 8888888888888  8 8888 88.        8 8888 8 888888<       8 8888            ,8;   `8.`88;   `8.`8888.    8   `Y8o. `Y8888 88 8888        ,8P 8 8888         88 8888      `8,8P  8 8888`8b           `8.`8888.        8 8888       8 8888      88       `8.`888b8;             `8.`888b8.`8888;          .8;`8.`8888.          `8 8888         ,8;,8888;       8 888             8888 8          '
		'    .8;   `8. `88888.   8 8888      88 `8 8888       .8; 8 8888        ,88; 8 8888         8 8888          `8 8888       .8; 8 8888        8  8 8888 `88.       8 888; 8 8888 `Y8.     8 8888           ,8;     `8.`;     `8.`8888.   8      `Y8o. `Y8 `8 8888       ,8P  8 8888         `8 8888       ;8P   8 8888 `8b.     8b   `8.`8888.       8 8888       ` 8888     ,8P        `8.`888;               `8.`888`8.`88;          .8;  `8.`8888.          8 8888        ,8;,8888;                                          '
		'.. .888888888. `88888.  8 8888    ,88;    8888     ,88;  8 8888    ,o88P;   8 8888         8 8888             8888     ,88;  8 8888        8  8 8888   `88o.    8 88;  8 8888   `Y8.   8 8888          ,8;       `8        `8.`8888.  8         `Y8o.`  ` 8888     ,88;   8 8888          ` 8888     ,88;8.  8 8888   `8b.   `8b.  ;8.`8888       8 8888         8888   ,d8P          `8.`8;                 `8.`8; `8,`;          .8;    `8.`8888.         8 8888       ,8;,8888;         8 888 8 888      8888             '
		'88.8;       `8. `88888. 8 888888888P       `8888888P;    8 888888888P;      8 888888888888 8 8888              `8888888P;    8 8888        8  8 8888     `Y888888 ;    8 8888     `Y8. 8 888888888888 ,8;         `         `8.`8888. 8            `Yo     `8888888P;     8 8888             `8888888P;  `8. 8 8888     `88.  `Y8888P ,88P;       8 8888          `Y88888P;            `8.`                   `8.`   `8;          .8;      `8.`8888.        8 8888      ,8;,8888888888888  8 888    88      8888             '
		)                                                                               
	  
	# Get words and spaces
	WORD="${@}"
	SPACE=$(( ${LETTERWID[1]} / 2 )) 
	tput sc
	
	STARTWID=0 # Start Width
	CNTLINES=0 # Line counter

	for LETTERNUM in $( seq 0 $(( ${#WORD} -1 )) ); do
		tput rc															# Save cursor positoin
		LETTER=${WORD:LETTERNUM:1} 										# Get letter from WORD (string)
		if [ "$LETTER" == " " ]; then									# If letter is space skip
			(( STARTWID+=SPACE ))
			tput cud $LETTERHGT
			continue
		fi
		LETTER=$(tr [:lower:] [:upper:] <<< $LETTER)					# Convert to supper to match position
		LETTERIDX=$(echo ${LETTERSET[@]}|sed "s/${LETTER}.*//"|wc -w)		# Get position
		LETTERSUM="${LETTERWID[@]:0:LETTERIDX}"
		LETTERSUM=$( echo "0${LETTERSUM// /+}+0" |bc)
		#LETTERIDX=$( echo "0${LETTERSUM// /+}+0" |bc)				# Get potion in LETTERDES

		if [ $(( STARTWID + LETTERWID[LETTERIDX] )) -ge $WINCOLS ]; then
			tput cud $LETTERHGT
			tput sc

			STARTWID=0
			(( CNTLINES++ ))
			if [ $CNTLINES -ge $(( ( WINROWS / LETTERHGT ) - 1 )) ]; then
				sleep 2
				clear
				tput sc
				CNTLINES=0
			fi
		fi
		
		# For each line in letter hight move to letter position and draw
		for INDEX in $( seq 0 ${LETTERHGT} ); do
			LINE=${LETTERDES[INDEX]}
			[ $STARTWID -ne 0 ] && tput cuf $STARTWID
			printf "${LINE:LETTERSUM:LETTERWID[LETTERIDX]}\n"
		done

		STARTWID=$(( STARTWID + ${LETTERWID[LETTERIDX]} ))
	done
}
