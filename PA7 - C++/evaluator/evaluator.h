#include <exception>
#include <string>
#include <stack>
#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>

#include "evaluator_exception.h"

template<typename T>
T transpose(const T& a) { return a; } // general transpose does nothing, is just the same as the argument

/*! Evalutates postfix expressions */
template<typename Argument_type=double,int Log_level=0>
class Evaluator
{
 public:
    Evaluator() {}

    /*! Evalutates the postfix expression it reads from input stream
      'is' and returns the result as Argument_type. An example of an
      expression is "a1.txt a2.txt + a3.txt *" which results in
      (a1+a2)*a3 where aX is the data read from file 'aX.txt'.
    */
    Argument_type evaluate(std::istream& is)
    {
        std::stack<std::string> elements;
        std::string element;
        int intermediate_count=0;
        while (is>>element)
        {
            if (Log_level>=1) std::cout<<"reading element:'"<<element<<"'"<<'\n';
            if (nr_arguments_operator(element)>0) // if element is an operator
            {
                std::string filename=get_intermediate_filename(intermediate_count++);
                Argument_type result=operate(element,elements);
                std::ofstream file(filename);
                if (!file.is_open())
                    throw Evaluator_exception("Could not write to file '"+filename+"'.");
                file<<result;            // write result to intermediate file and
                elements.push(filename); // push its filename onto the stack
            }
            else
                elements.push(element);
        }
        if (elements.size()>1)
            throw Evaluator_exception("Invalid expression, more than one argument remains after evaluation");
        if (elements.size()==0)
            return Argument_type{};
        std::string result_file=elements.top();
        std::ifstream file(result_file);
        if (!file.is_open())
            throw Evaluator_exception("Could not open result file '"+result_file+"'.");
        Argument_type result;
        file>>result;
        return result;
    }
 
 private:
    /*! Returns a filename to store intermediate results in. Parameter 'i'
      is used to make the filename unique.
    */
    std::string get_intermediate_filename(int i)
    {
        std::stringstream ss;
        ss<<"intermediate_result_"<<std::setfill('0')<<std::setw(5)<<i<<".txt";
        return ss.str();
    }

    /*! Returns the number of arguments associated with operator 'my_operator'.
     */
    int nr_arguments_operator(std::string my_operator)
    {
        if (my_operator=="+" || my_operator=="-" || my_operator=="*") return 2;
        if (my_operator=="~" || my_operator=="'")                     return 1;
        return 0;
    }

    /*! Pops the filename from the top of the 'elements' stack, reads the
      data in it and returns that result.
    */
    Argument_type read_argument_from_stack(std::stack<std::string>& elements)
    {
        if (elements.empty())
            throw Evaluator_exception("No arguments on stack to apply operator on");
        const std::string& element=elements.top();
        std::ifstream file(element);
        if (!file.is_open())
            throw Evaluator_exception("Could not open file '"+element+"'.");
        elements.pop();
        Argument_type argument;
        file>>argument;
        return argument;
    }
 
    /*! Evalutates an expression with operator 'my_operator' and pops the
      associated number of arguments from the 'elements' stack.  The result
      of the expression is returned.
    */
    Argument_type operate(std::string my_operator,std::stack<std::string>& elements)
    {
        Argument_type a1=read_argument_from_stack(elements);
        if (nr_arguments_operator(my_operator)==1) // operator with 1 argument
        {
            if (Log_level>=2) std::cout<<"evaluating: "<<my_operator<<" "<<a1<<'\n';
            if (my_operator=="~") return -a1;
            if (my_operator=="'") return transpose(a1);
        }
        else if (nr_arguments_operator(my_operator)==2) // operator with 2 argument
        {
            Argument_type a2=read_argument_from_stack(elements);
            if (Log_level>=2) std::cout<<"evaluating: "<<a1<<" "<<my_operator<<" "<<a2<<'\n';
            if (my_operator=="+")      return a2+a1; // reverse order, as they come of the stack in reverse
            else if (my_operator=="-") return a2-a1;
            else if (my_operator=="*") return a2*a1;
        }
        throw Evaluator_exception("Unkown operator '"+my_operator+"'.");
    }

};
