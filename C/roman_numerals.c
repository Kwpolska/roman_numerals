/*
 * Roman Numeral Converter
 * Copyright © MMXVI, Chris Warrick.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions, and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions, and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the author of this software nor the names of
 *    contributors to this software may be used to endorse or promote
 *    products derived from this software without specific prior written
 *    consent.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int to_roman(int integer, char* roman);
int from_roman(char* roman);
int prepare_group(int integer, char* roman, int* i, int group_value, char group_letter, int lower_value, char lower_letter);
int _rn_value(char ch, char nch);

// roman is char[16]
int to_roman(int integer, char* roman) {
    if (integer < 1 || integer > 3999) {
        return -1;
    }

    int i = 0;
    integer = prepare_group(integer, roman, &i, 1000, 'M', 900, 'C');
    integer = prepare_group(integer, roman, &i, 500, 'D', 400, 'C');
    integer = prepare_group(integer, roman, &i, 100, 'C', 90, 'X');
    integer = prepare_group(integer, roman, &i, 50, 'L', 40, 'X');
    integer = prepare_group(integer, roman, &i, 10, 'X', 9, 'I');
    integer = prepare_group(integer, roman, &i, 5, 'V', 4, 'I');
    integer = prepare_group(integer, roman, &i, 1, 'I', 0, ' ');
    roman[i] = '\0';

    return i;
}

int from_roman(char* roman_) {
    int integer = 0;
    // convert to upper case
    char *roman = (char*)malloc(16);
    strncpy(roman, roman_, 16);
    roman[15] = '\0';
    int length = strlen(roman);
    for (int i = 0; i < length; i++) {
        if (roman[i] >= 'a' && roman[i] <= 'z') {
            roman[i] = roman[i] - 0x20;
        }
    }

    for (int i = 0; i < length; i++) {
        char ch = roman[i];
        char nch = roman[i + 1];
        integer += _rn_value(ch, nch);
    }
    free(roman);
    return integer;
}


int prepare_group(int integer, char* roman, int* i, int group_value, char group_letter, int lower_value, char lower_letter) {
    int count = integer / group_value;
    integer = integer % group_value;
    for (int j = 0; j < count; j++) {
        roman[*i] = group_letter;
        *i += 1;
    }
    if (lower_value != 0 && integer >= lower_value) {
        roman[*i] = lower_letter;
        *i += 1;
        roman[*i] = group_letter;
        *i += 1;
        integer -= lower_value;
    }
    return integer;
}

int _rn_value(char ch, char nch) {
    switch (ch) {
        case 'M':
            return 1000;
        case 'D':
            return 500;
        case 'C':
            if (nch == 'M' || nch == 'D') {
                return -100;
            } else {
                return 100;
            }
        case 'L':
            return 50;
        case 'X':
            if (nch == 'C' || nch == 'L') {
                return -10;
            } else {
                return 10;
            }
        case 'V':
            return 5;
        case 'I':
            if (nch == 'X' || nch == 'V') {
                return -1;
            } else {
                return 1;
            }
        case '\0':
            return 0;
    }
    // better error handling?
    return 0;
}
