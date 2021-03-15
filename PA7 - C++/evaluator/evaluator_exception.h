#ifndef EVALUATOR_EXCEPTION_INCLUDED
#define EVALUATOR_EXCEPTION_INCLUDED

#include <exception>
#include <string>

/*! Expression to be used in the evaluator. */
class Evaluator_exception : public std::exception
{
    std::string description;
public:
    /*! Constructor */
    Evaluator_exception(std::string description) : description{description} {}
    /*! Get description */
    virtual char const * what() const noexcept { return description.c_str(); }
};

#endif
