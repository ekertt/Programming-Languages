/*
Author: Tim van Ekert (13635565)
Study: Software Engineering HvA, Pre master SE UvA
Version: 1
Description: This program is a definition of a custom string on four different operators.
*/

#ifndef STR_INCLUDED
#define STR_INCLUDED

#include <string>
#include <sstream>
#include <iostream>

class Str
{
public:
    Str() : matrix_string{""} {}
    Str(std::string s)
    {
        matrix_string = s;
    }

    std::string getString() const
    {
        return matrix_string;
    }

    friend std::istream &operator>>(std::istream &is, Str &string);

private:
    std::string matrix_string;
};

// Reads a Str string from input stram
std::istream &operator>>(std::istream &is, Str &string)
{
    std::string temp;

    while (getline(is, temp))
    {
        string.matrix_string = temp;
    }

    return is;
}

// Writes a Str string to output stream
std::ostream &operator<<(std::ostream &os, const Str &string)
{
    os << string.getString();
    return os;
}

// Helper for the operator functions to print the correct output
std::string operatorHelper(std::string firstString, std::string operatorType, std::string secondString)
{
    if (secondString == "")
    {
        return "(" + operatorType + firstString + ")";
    }
    else
    {
        return "(" + firstString + operatorType + secondString + ")";
    }
}

// Returns the addition of the two given Str strings
Str operator+(const Str &firstString, const Str &secondString)
{
    return operatorHelper(firstString.getString(), "+", secondString.getString());
}

// Returns the addition of the two given Str strings
Str operator*(const Str &firstString, const Str &secondString)
{
    return operatorHelper(firstString.getString(), "*", secondString.getString());
}

// Returns the subtraction of the two given Str strings
Str operator-(const Str &firstString, const Str &secondString)
{
    return operatorHelper(firstString.getString(), "-", secondString.getString());
}

// Returns the negation of the given Str string
Str operator-(const Str &string)
{
    return operatorHelper(string.getString(), "-", "");
}

#endif