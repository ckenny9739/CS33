//
//  switch.c
//  HW2
//
//  Created by Connor Kenny - 304437322 - on 4/16/15.
//  Copyright (c) 2015 Connor Kenny. All rights reserved.
//

// 3.59

 int switch_prob(int x, int n)
 {
	int result  = x;
	switch (n) {
        /* when n is less than 50, line 6 of the assembly makes it negative
         the unsigned comparison will always evaluate to greater than and jump to default */
        case 50:
            /* doesn't jump anywhere and continues on to next step */
        case 52:
            x <<= 2;
            break;
        case 53:
            x >>= 2;
            break;
        case 54:
            x *= 3;
            /* use leal to multiply x by 3
             there is no jump so that means there is no break here, continue onwards */
        case 55:
            x *= x;
            /* again, no break here so keep going */
        case 51:
        default:
            /* n is < 50, 51, or > 55 */
            x += 10;
    }
	return result;
 }

