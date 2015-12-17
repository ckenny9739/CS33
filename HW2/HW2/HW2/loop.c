//
//  loop.c
//  HW2
//
//  Created by Connor Kenny -304437322 - on 4/16/15.
//  Copyright (c) 2015 Connor Kenny. All rights reserved.
//

/*
3.56

A:
x is in %esi
n is in %ebx
result is in %edi
mask is in %edx

B:
Initial values :
result : -1
mask : 1

C: Test condition - Check whether or not mask equals 0

D: mask gets left shifted by n bits in line #10

E: result gets the value that results from an XOR of (x & mask)

F: See code below
*/

int loop(int x, int n)
{
    int result = -1;
    int mask;
    for (mask = 1; mask != 0; mask = mask << n){
        result ^= (mask & x);
    }
    return result;
}
