//
//  hello-thread.c
//  HW5 - Number 16
//
//  Created by Connor Kenny on 5/19/15.
//  Copyright (c) 2015 Connor Kenny. All rights reserved.
//
// Write a version of hello.c (Figure 12.13) that creates and reaps n joinable peer threads
// where n is a command line argument.

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *thread(void *vargp);

int main(int argc, char* argv[]) {
    pthread_t tid;
    long n = strtol(argv[1], NULL, 0);
    int i;
    for (i=0; i < n; i++)
    {
        pthread_create(&tid, NULL, thread, NULL);
        pthread_join(tid, NULL);
    }
    exit(0);
}
    

void *thread(void *vargp) /* Thread routine */
{
    printf("Hello, world!\n");
    return NULL;
    }

