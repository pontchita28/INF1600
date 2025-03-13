/*
INF1600 - TP3 - Visualisation de la serie de Mandelbrot
Auteur: Abdul-Wahab Chaarani
Date: 3/12/2025
Version: 2.0
Description: Tests automatises.
*/
#include <iostream>
#include <fstream>
#include <sstream>
#include <complex>
#include <iomanip>
#include <random>
#include <string>
#include "complex.hpp"
#include "mandelbrot.hpp"
#include "tests.hpp"

const std::string ansiColorRed = "\x1b[31m";
const std::string ansiColorGreen = "\x1b[32m";
const std::string ansiColorYellow = "\x1b[33m";
const std::string ansiColorBlue = "\x1b[34m";
const std::string ansiColorMagenta = "\x1b[35m";
const std::string ansiColorCyan = "\x1b[36m";
const std::string ansiColorReset = "\x1b[0m";

////////////// NE PAS MODIFIER CE QUI SUIT //////////////////
const int nTests{7};
int testValues[] = {10, 0, 0, 10, 15, 15, 50};
std::string tests[] = {"constructor, realPart(), imagPart(), modulus(), operator+, operator*, mandelbrot recursive"};
int testResults[7];

float generateRandomFloat()
{
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(-10.0, 10.0);
    return dis(gen);
}

bool areFloatsEqual(float a, float b, float epsilon = 1e-4)
{
    return std::fabs(a - b) < epsilon;
}

int complexConstructorTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Complex: Constructeur" << std::endl;

    float a = generateRandomFloat();
    float b = generateRandomFloat();

    Complex result{a, b};
    std::complex expected{a, b};

    std::cout << ansiColorYellow;
    std::cout << std::setw(12) << std::left << "result: " << result << std::endl;
    std::cout << std::setw(12) << std::left << "expected:  " << expected << std::endl;
    if (result.real != a || result.imag != b)
    {
        std::cout << ansiColorRed << "Les attributs de la classe ne sont pas initialises adequatement" << std::endl;
    }
    //     std::cout << ansiColorRed << "Attribut -real- n'est pas initialise adequatement" << std::endl;
    // if (result.imag != b)
    // if (result.real == a && result.imag == b){
    else
    {
        std::cout << ansiColorGreen << "Test Constructeur OK!" << '\n';
        // testResults[0] = testValues[0];
        points = testValues[0];
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

int complexRealPartTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Complex: realPart" << std::endl;
    float a = generateRandomFloat();
    float b = generateRandomFloat();

    Complex c{a, b};
    float result = c.realPart();

    std::complex stdc{a, b};
    float expected = stdc.real();

    std::cout << ansiColorYellow;
    std::cout << std::setw(12) << std::left << "result: " << result << std::endl;
    std::cout << std::setw(12) << std::left << "expected:  " << expected << std::endl;
    std::cout << ansiColorRed;
    if (!areFloatsEqual(result, expected))
        std::cout << ansiColorRed << "realPart() n'obtient pas adequatement la partie reelle du nombre complexe" << std::endl;
    else
    {
        points = testValues[1];
        std::cout << ansiColorGreen << "Test realPart() OK!" << std::endl;
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

int complexImagPartTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Complex: imagPart" << std::endl;
    float a = generateRandomFloat();
    float b = generateRandomFloat();

    Complex c{a, b};
    float result = c.imagPart();

    std::complex stdc{a, b};
    float expected = stdc.imag();

    std::cout << ansiColorYellow;
    std::cout << std::setw(12) << std::left << "result: " << result << std::endl;
    std::cout << std::setw(12) << std::left << "expected:  " << expected << std::endl;
    std::cout << ansiColorRed;
    if (!areFloatsEqual(result, expected))
        std::cout << ansiColorRed << "imagPart() n'obtient pas adequatement la partie reelle du nombre complexe" << std::endl;
    else
    {
        std::cout << ansiColorGreen << "Test imagPart() OK!" << std::endl;
        points = testValues[2];
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

int complexOperationPlTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Complex: operator+" << std::endl;
    float a = generateRandomFloat();
    float b = generateRandomFloat();

    float c = generateRandomFloat();
    float d = generateRandomFloat();

    Complex c1{a, b};
    Complex c2{c, d};

    std::complex stdc1{a, b};
    std::complex stdc2{c, d};

    Complex result = c1 + c2;
    std::complex expected = stdc1 + stdc2;

    std::cout << ansiColorYellow;
    std::cout << std::setw(12) << std::left << "result: " << result << std::endl;
    std::cout << std::setw(12) << std::left << "expected:  " << expected << std::endl;
    std::cout << ansiColorRed;
    if (!areFloatsEqual(result.real, expected.real()) || !areFloatsEqual(result.imag, expected.imag()))
        std::cout << ansiColorRed << "La surcharge de operateur+ entre 2 Complex ne fonctionne pas adequatement" << std::endl;
    else
    {
        std::cout << ansiColorGreen << "Test operator+ OK!" << std::endl;
        points = testValues[3];
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

int complexOperationMlTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Complex: operator*" << std::endl;
    float a = generateRandomFloat();
    float b = generateRandomFloat();

    float c = generateRandomFloat();
    float d = generateRandomFloat();

    Complex c1{a, b};
    Complex c2{c, d};

    std::complex stdc1{a, b};
    std::complex stdc2{c, d};

    Complex result = c1 * c2;
    std::complex expected = stdc1 * stdc2;

    std::cout << ansiColorYellow;
    std::cout << std::setw(12) << std::left << "result: " << result << std::endl;
    std::cout << std::setw(12) << std::left << "expected:  " << expected << std::endl;
    std::cout << ansiColorRed;
    if (!areFloatsEqual(result.real, expected.real()) || !areFloatsEqual(result.imag, expected.imag()))
        std::cout << ansiColorRed << "La surcharge de operateur* entre 2 Complex ne fonctionne pas adequatement" << std::endl;
    else
    {
        std::cout << ansiColorGreen << "Test operator* OK!" << std::endl;
        points = testValues[4];
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

int complexModulusTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Complex: modulus" << std::endl;
    float a = generateRandomFloat();
    float b = generateRandomFloat();

    Complex c1{a, b};

    std::complex stdc1{a, b};

    float result = c1.modulus();
    float expected = std::abs(stdc1);

    std::cout << ansiColorYellow;
    std::cout << std::setw(12) << std::left << "result:" << result << std::endl;
    std::cout << std::setw(12) << std::left << "expected:  " << expected << std::endl;
    std::cout << ansiColorRed;
    if (!areFloatsEqual(result, expected))
        std::cout << ansiColorRed << "Le calcul du module du Complex ne fonctionne pas adequatement" << std::endl;
    else
    {
        std::cout << ansiColorGreen << "Test modulus OK!" << std::endl;
        points = testValues[5];
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

int mandelbrotCpp(std::complex<float> &z, std::complex<float> &c, int count)
{
    if (std::abs(z) >= escapeRadius)
        return count;
    if (count + 1 > maxIterations)
        return count;
    z = z * z + c;
    return mandelbrotCpp(z, c, ++count);
}

int mandelbrotRecurseTest()
{
    int points{0};

    std::cout << ansiColorBlue << "TEST - Mandelbrot recursif" << std::endl;
    float a = generateRandomFloat();
    float b = generateRandomFloat();

    float c = -0.654914696f;
    float d = -0.414947684f;

    float e = 0.338217f;
    float f = 0.521817f;

    float g = -0.260607f;
    float h = -0.769514f;

    Complex z0{0, 0};
    Complex c0 = z0;

    Complex zRandom{a, b};
    Complex cRandom = zRandom;

    Complex zKnown1{c, d};
    Complex cKnown1 = zKnown1;

    Complex zKnown2{e, f};
    Complex cKnown2 = zKnown2;

    Complex zKnown3{g, h};
    Complex cKnown3 = zKnown3;

    Complex zBig{3, 4};
    Complex cBbig = zBig;

    std::complex<float> stdC0{0, 0};
    std::complex<float> stdZ0 = stdC0;

    std::complex<float> stdZRandom{a, b};
    std::complex<float> stdCRandom = stdZRandom;

    std::complex<float> stdZKnown1{c, d};
    std::complex<float> stdCKnown1 = stdZKnown1;

    std::complex<float> stdZKnown2{e, f};
    std::complex<float> stdCKnown2 = stdZKnown2;

    std::complex<float> stdZKnown3{g, h};
    std::complex<float> stdCKnown3 = stdZKnown3;

    std::complex<float> stdZBig{3, 4};
    std::complex<float> stdCBig = stdZBig;

    int result0 = mandelbrotSet(z0, c0, 0);
    int expected0 = mandelbrotCpp(stdZ0, stdC0, 0);

    int resultKnown1 = mandelbrotSet(zKnown1, cKnown1, 0);
    int expectedKnown1 = mandelbrotCpp(stdZKnown1, stdCKnown1, 0);

    int resultKnown2 = mandelbrotSet(zKnown2, cKnown2, 0);
    int expectedKnown2 = mandelbrotCpp(stdZKnown2, stdCKnown2, 0);

    int resultKnown3 = mandelbrotSet(zKnown3, cKnown3, 0);
    int expectedKnown3 = mandelbrotCpp(stdZKnown3, stdCKnown3, 0);

    int resultRandom = mandelbrotSet(zRandom, cRandom, 0);
    int expectedRandom = mandelbrotCpp(stdZRandom, stdCRandom, 0);

    int resultBig = mandelbrotSet(zBig, cBbig, 0);
    int expectedBig = mandelbrotCpp(stdZBig, stdCBig, 0);

    std::cout << ansiColorYellow;
    std::cout << std::setw(20) << std::left << "result   (0, 0):" << result0 << std::endl;
    std::cout << std::setw(20) << std::left << "expected (0, 0): " << expected0 << std::endl;
    std::cout << std::setw(10) << std::left << "result   (" << c << "," << d << "): " << resultKnown1 << std::endl;
    std::cout << std::setw(10) << std::left << "expected (" << c << "," << d << "): " << expectedKnown1 << std::endl;
    std::cout << std::setw(10) << std::left << "result   (" << e << "," << f << "): " << resultKnown2 << std::endl;
    std::cout << std::setw(10) << std::left << "expected (" << e << "," << f << "): " << expectedKnown2 << std::endl;
    std::cout << std::setw(10) << std::left << "result   (" << g << "," << h << "): " << resultKnown3 << std::endl;
    std::cout << std::setw(10) << std::left << "expected (" << g << "," << h << "): " << expectedKnown3 << std::endl;
    std::cout << std::setw(20) << std::left << "result   (3, 4):" << resultBig << std::endl;
    std::cout << std::setw(20) << std::left << "expected (3, 4): " << expectedBig << std::endl;
    std::cout << "result -- random --  (" << a << "," << b << "): " << resultRandom << std::endl;
    std::cout << "expected --random -- (" << a << "," << b << "): " << expectedRandom << std::endl;
    std::cout << ansiColorRed;
    if (result0 != expected0 || resultRandom != expectedRandom || resultKnown1 != expectedKnown1 || resultKnown2 != expectedKnown2 || resultKnown3 != expectedKnown3 || resultBig != expectedBig)
        std::cout << ansiColorRed << "La fonction recursive de Mandelbrot ne fonctionne pas" << std::endl;
    else
    {
        std::cout << ansiColorGreen << "Test Mandelbrot recursif OK!" << std::endl;
        points = testValues[6];
    }
    std::cout << ansiColorReset << std::endl;
    return points;
}

void runTests()
{
    complexConstructorTest();
    complexOperationPlTest();
    complexOperationMlTest();
    complexModulusTest();
    mandelbrotRecurseTest();
}