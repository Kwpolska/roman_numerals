/*
 * Test Suite for Roman Numeral Converter
 * Copyright © MMXVI-MMXVII, Chris Warrick.
 * All rights reserved.
 * License: 3-clause BSD, see main file for details.
 */

#include "roman_numerals.c"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int test_tr(int integer, char* roman) {
    char *output = (char*)malloc(16);
    to_roman(integer, output);
    int ret;
    if (strcmp(output, roman) == 0) {
        putchar('.');
        ret = 0;
    } else {
        putchar('F');
        ret = 1;
    }
    free(output);
    return ret;
}

int test_tr_error(int integer) {
    char *output = (char*)malloc(16);
    int val = to_roman(integer, output);
    int ret;
    if (val == -1) {
        putchar('.');
        ret = 0;
    } else {
        putchar('F');
        ret = 1;
    }
    free(output);
    return ret;

}


int test_fr(int integer, char* roman) {
    int output = from_roman(roman);
    if (output == integer) {
        putchar('.');
        return 0;
    } else {
        putchar('F');
        return 1;
    }
}

int main() {
    FILE* fh = fopen("../test_data.txt", "r");
    char* line = (char*)malloc(32);
    char *output_to = (char*)malloc(16);
    int output_from;
    int integer;
    char* roman;
    int errors = 0;
    char* token;

    // edge cases test
    printf("to_roman");
    errors += test_tr(1, "I");
    errors += test_tr(2, "II");
    errors += test_tr(3, "III");
    errors += test_tr(4, "IV");
    errors += test_tr(5, "V");
    errors += test_tr(6, "VI");
    errors += test_tr(1234, "MCCXXXIV");
    errors += test_tr(1958, "MCMLVIII");
    errors += test_tr(2222, "MMCCXXII");
    errors += test_tr(3999, "MMMCMXCIX");

    printf("\nto_roman errors");
    test_tr_error(0);
    test_tr_error(-1);
    test_tr_error(4000);

    printf("\nfrom_roman");
    test_fr(1, "I");
    test_fr(2, "Ii");
    test_fr(3, "iii");
    test_fr(4, "  iv  ");
    test_fr(5, "V");
    test_fr(8, "ViIi");

    // file tests
    printf("\nall inputs...");
    while (fgets(line, 32, fh) != NULL) {
        token = strtok(line, " ");
        integer = atoi(token);
        roman = strtok(NULL, " ");
        // remove \n
        roman = strtok(roman, "\n");

        // make buffer and test
        to_roman(integer, output_to);
        if (strcmp(roman, output_to) != 0) {
            printf("ERROR: to_roman, expected %s, received %s\n", roman, output_to);
            errors++;
        }

        output_from = from_roman(roman);
        if (output_from != integer) {
            printf("ERROR: from_roman, expected %d, received %d\n", integer, output_from);
            errors++;
        }
    }
    printf("\n");
    if (errors == 0) puts("PASS");
    else printf("%d ERRORS\n", errors);
    free(line);
    free(output_to);
    return errors != 0;
}
