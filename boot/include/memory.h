#ifndef _memory_functions_h
#define _memory_functions_h  "memory functions"

#include <types.h>

void set_es (size_t val);
void set_fs (size_t val);
void set_gs (size_t val);

int read_es (size_t offset);
int read_fs (size_t offset);
int read_gs (size_t offset);

void write_es (size_t offset, int val);
void write_fs (size_t offset, int val);
void write_gs (size_t offset, int val);

#endif