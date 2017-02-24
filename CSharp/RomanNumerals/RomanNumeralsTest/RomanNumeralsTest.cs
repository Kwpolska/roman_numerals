using System;
using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace RomanNumeralsTest {
    [TestClass]
    public class RomanNumeralsTest {
        [TestMethod]
        public void TestToRoman() {
            Assert.AreEqual("I", RomanNumerals.RomanNumerals.ToRoman(1));
            Assert.AreEqual("II", RomanNumerals.RomanNumerals.ToRoman(2));
            Assert.AreEqual("III", RomanNumerals.RomanNumerals.ToRoman(3));
            Assert.AreEqual("IV", RomanNumerals.RomanNumerals.ToRoman(4));
            Assert.AreEqual("V", RomanNumerals.RomanNumerals.ToRoman(5));
            Assert.AreEqual("VI", RomanNumerals.RomanNumerals.ToRoman(6));

            Assert.AreEqual("MCCXXXIV", RomanNumerals.RomanNumerals.ToRoman(1234));
            Assert.AreEqual("MCMLVIII", RomanNumerals.RomanNumerals.ToRoman(1958));
            Assert.AreEqual("MMCCXXII", RomanNumerals.RomanNumerals.ToRoman(2222));
            Assert.AreEqual("MMMCMXCIX", RomanNumerals.RomanNumerals.ToRoman(3999));
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void TestToRomanInvalid1() {
            RomanNumerals.RomanNumerals.ToRoman(-1);
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void TestToRomanInvalid0() {
            RomanNumerals.RomanNumerals.ToRoman(0);
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void TestToRomanInvalid4000() {
            RomanNumerals.RomanNumerals.ToRoman(4000);
        }

        [TestMethod]
        public void TestToRomanFile() {
            using (StreamReader sr = File.OpenText("../../../../../test_data.txt")) {
                while (!sr.EndOfStream) {
                    string line = sr.ReadLine().Trim();
                    if (line == "") break;
                    string[] l = line.Split(' ');
                    int integer = int.Parse(l[0]);
                    string roman = l[1];
                    Assert.AreEqual(roman, RomanNumerals.RomanNumerals.ToRoman(integer));
                }
            }
        }

        [TestMethod]
        public void TestFromRoman() {
            Assert.AreEqual(1, RomanNumerals.RomanNumerals.FromRoman("I"));
            Assert.AreEqual(2, RomanNumerals.RomanNumerals.FromRoman("Ii"));
            Assert.AreEqual(3, RomanNumerals.RomanNumerals.FromRoman("iii"));
            Assert.AreEqual(4, RomanNumerals.RomanNumerals.FromRoman("  iv  "));
            Assert.AreEqual(5, RomanNumerals.RomanNumerals.FromRoman("V"));
            Assert.AreEqual(8, RomanNumerals.RomanNumerals.FromRoman("ViIi"));
        }

        [TestMethod]
        public void TestFromRomanFile() {
            using (StreamReader sr = File.OpenText("../../../../../test_data.txt")) {
                while (!sr.EndOfStream) {
                    string line = sr.ReadLine().Trim();
                    if (line == "") break;
                    string[] l = line.Split(' ');
                    int integer = int.Parse(l[0]);
                    string roman = l[1];
                    Assert.AreEqual(integer, RomanNumerals.RomanNumerals.FromRoman(roman));
                }
            }
        }
    }
}
