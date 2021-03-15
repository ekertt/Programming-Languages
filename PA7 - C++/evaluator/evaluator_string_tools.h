#ifndef EVALUATOR_STRING_TOOLS_INCLUDED
#define EVALUATOR_STRING_TOOLS_INCLUDED
#include <string>
#include <sstream>
#include <vector>
#include <algorithm>
#include <iterator>

/*! Converts string to template type T */
template<typename T>
T string_to(std::string s);
/*! Template specialization, converts string to double */
template<>
double string_to<double>(std::string s) { return stod(s); }
/*! Template specialization, converts string to int */
template<>
int string_to<int>(std::string s) { return stoi(s); }

/*! Splits string 'str' by delimiter 'delim' in a vector of strings and returns it. */
std::vector<std::string> split(const std::string& str, char delim = ' ')
{
    std::vector<std::string> vec;
    std::stringstream ss(str);
    std::string token;
    while (std::getline(ss, token, delim))
    {
        vec.push_back(token);
    }
    return vec;
}

/*! Returns left trimmed version of s. */
static inline std::string &ltrim(std::string &s)
{
    auto not_space_iterator= std::find_if(s.begin(), s.end(),
                                          [](char ch) { return !std::isspace(ch); } );
    s.erase(s.begin(), not_space_iterator);
    return s;
}

/*! Returns right trimmed version of s. */
static inline std::string &rtrim(std::string &s)
{
    auto not_space_iterator= std::find_if(s.rbegin(), s.rend(), // 'r' for reverse iterator
                                          [](char ch) { return !std::isspace(ch); } ).base();
    s.erase(not_space_iterator, s.end());
    return s;
}

/*! Returns both sides trimmed version of s. */
std::string& trim(std::string &str)
{   return ltrim(rtrim(str)); }

#endif
