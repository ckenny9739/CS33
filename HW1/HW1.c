//
//  main.c
//  HW1
//
//  Created by Connor Kenny on 4/1/15.
//  Copyright (c) 2015 Connor Kenny. All rights reserved.
//

#include <stdio.h>
#include <limits.h>

// 2.66
/*
int leftmost_one(unsigned x) {
    x |= (x >> 16);
    x |= (x >> 8);
    x |= (x >> 4);
    x |= (x >> 2);
    x |= (x >> 1);
    return (x >> 1) + 1;
}

int main(int argc, const char * argv[]) {
    printf("0x%X", leftmost_one(0xFF00));
    return 0;
}
*/

//2.71

typedef unsigned packed_t;

int xbyte(packed_t word, int bytenum)
{
    return (word >> (bytenum << 3)) & 0xFF;
}

int main(int argc, const char * argv[]) {
    printf("0x%X", xbyte(0x1234, 0));
    return 0;
}


//2.72

//2.81