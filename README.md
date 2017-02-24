Roman Numeral Converters
========================

This is a collection of programs in various languages to convert to and from
Roman Numerals. Every version has a test suite with 100% code coverage.

Test data based on Gerard Schildberger’s list, as provided with
[OEIS sequence A006968](https://oeis.org/A006968/a006968.txt).

Supported Languages
-------------------

This list might grow soon...

* Python (2 and 3)
* C
* Java
* JavaScript
* Ruby
* Swift
* Lua
* C#

Testing/compiling
-----------------

Run `make` either from the top directory or from a language directory.
Requirements:

* Python — Python and py.test installed
* C — a C compiler installed
* Java — Java installed, `junit-4.12.jar` and `hamcrest-core-1.3.jar` in the Java folder
* JavaScript — node and npm installed; npm dependencies (`jest`) installed
* Ruby — Ruby installed
* Swift — Xcode installed (good luck!); the included executable *might* work on a Mac. (Apple would prefer people not to write CLI apps in Swift.)
* Lua — Lua installed; download [LuaUnit](https://github.com/bluebird75/luaunit/blob/master/luaunit.lua) manually and place in the `Lua/` directory
* C# — Visual Studio and the appropriate C# runtimes installed

Public API
----------

Each version has a slightly different public API.

* Python: `to_roman(integer)` — `from_roman(roman)`
* C: `int to_roman(int integer, char* roman)` (buffer of length 16) — `int from_roman(char* roman)`
* Java: `String RomanNumerals.toRoman(int integer)` — `int RomanNumerals.fromRoman(String roman)`
* JavaScript: `toRoman(integer)` — `fromRoman(roman)`
* Ruby: `to_roman(integer)` — `from_roman(roman)`
* Swift: `toRoman(integer: Int)` — `fromRoman(roman: String)`
* Lua: `to_roman(integer)` — `from_roman(roman)`
* C#: `string RomanNumerals.ToRoman(int integer)` — `int RomanNumerals.FromRoman(string roman)`

License
-------

Copyright © MMXVI-MMXVII, Chris Warrick.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions, and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions, and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

3. Neither the name of the author of this software nor the names of
   contributors to this software may be used to endorse or promote
   products derived from this software without specific prior written
   consent.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
