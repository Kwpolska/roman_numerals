using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RomanNumerals {
    public class RomanNumerals {
        private int integer;
        private StringBuilder roman;
        private static readonly Dictionary<char, int> CHAR_VALUES = new Dictionary<char, int> {
            {'M', 1000},
            {'D', 500},
            {'C', 100},
            {'L', 50},
            {'X', 10},
            {'V', 5},
            {'I', 1}
        };
        private static readonly Dictionary<char, string> CHAR_PRECEDENCE = new Dictionary<char, string> {
            {'C', "MD"},
            {'X', "CL"},
            {'I', "XV"}
        };

        RomanNumerals(int integer_) {
            integer = integer_;
            roman = new StringBuilder();
            roman.EnsureCapacity(16);
        }

        private void PrepareGroup(int groupValue, char groupLetter, int lowerValue, char lowerLetter) {
            int count = integer / groupValue;
            integer = integer % groupValue;
            for (int i = 0; i < count; i++) {
                roman.Append(groupLetter);
            }

            if (lowerValue != 0 && integer >= lowerValue) {
                roman.Append(lowerLetter);
                roman.Append(groupLetter);
                integer -= lowerValue;
            }
        }

        override public string ToString() {
            return roman.ToString();
        }

        public static int FromRoman(string roman_) {
            int integer = 0;
            string roman = roman_.Trim().ToUpper();
            int length = roman.Length;
            int maxidx = length - 1;
            char ch;
            char nch;
            for (int i = 0; i < length; i++) {
                ch = roman[i];
                if (i == maxidx) {
                    nch = '\0';
                } else {
                    nch = roman[i + 1];
                }

                if (CHAR_PRECEDENCE.ContainsKey(ch) && CHAR_PRECEDENCE[ch].Contains(nch)) {
                    integer -= CHAR_VALUES[ch];
                } else {
                    integer += CHAR_VALUES[ch];
                }
            }
            return integer;
        }

        public static string ToRoman(int integer) {
            RomanNumerals r = new RomanNumerals(integer);
            if (integer < 1 || integer > 3999) {
                throw new ArgumentOutOfRangeException("Integer must be between 1 and 3999");
            }
            r.PrepareGroup(1000, 'M', 900, 'C');
            r.PrepareGroup(500, 'D', 400, 'C');
            r.PrepareGroup(100, 'C', 90, 'X');
            r.PrepareGroup(50, 'L', 40, 'X');
            r.PrepareGroup(10, 'X', 9, 'I');
            r.PrepareGroup(5, 'V', 4, 'I');
            r.PrepareGroup(1, 'I', 0, '\0');
            return r.ToString();
        }
    }

}
