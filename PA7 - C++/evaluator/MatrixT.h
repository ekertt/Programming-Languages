#ifndef MATRIXT_INCLUDED
#define MATRIXT_INCLUDED

#include <vector>
#include <iostream>

#include "evaluator_exception.h"
#include "evaluator_string_tools.h"

/*! Represents a 2 dimensional matrix of template type T. */
template<typename T>
class MatrixT
{
    int m_rows,m_cols;
    std::vector<T> m_data;
 public:
    // constructors
    MatrixT()                  : m_rows{0},   m_cols{0}                      {}
    MatrixT(int rows,int cols) : m_rows{rows},m_cols{cols},m_data(rows*cols) {}

          std::vector<T>& vec()       { return m_data;}
    const std::vector<T>& vec() const { return m_data;}
    
    int nr_rows() const                     { return m_rows;}
    int nr_cols() const                     { return m_cols;}
          T& operator()(int r,int c)        { return m_data[r*m_cols+c];}
    const T& operator()(int r,int c) const  { return m_data[r*m_cols+c];}
    
    template<typename T2> friend std::istream& operator>>(std::istream& is,MatrixT<T2>& matrix); // give operator access to private variables
};

/*! Reads a Matrix from 'is' stream. */
template<typename T>
std::istream& operator>>(std::istream& is,MatrixT<T>& matrix)
{
    return is; // to be completed
}

/*! Writes Matrix 'matrix' to 'os' stream. */
template<typename T>
std::ostream& operator<<(std::ostream& os,const MatrixT<T>& matrix)
{
    return os; // to be completed
}

/*! Returns a new Matrix that is the negation of 'matrix'. */
template<typename T>
MatrixT<T> operator-(const MatrixT<T>& matrix)
{
    return matrix; // to be completed
}

/*! Returns a new Matrix that is the transpose of 'matrix'. */
template <typename T>
MatrixT<T> transpose(const MatrixT<T>& matrix)
{
    return matrix; // to be completed
}

/*! Returns a new Matrix that is equal to 'm1+m2'. */
template<typename T>
MatrixT<T> operator+(const MatrixT<T>& m1,const MatrixT<T>& m2)
{
    return m1; // to be completed
}

/*! Returns a new Matrix that is equal to 'm1-m2'. */
template<typename T>
MatrixT<T> operator-(const MatrixT<T>& m1,const MatrixT<T>& m2)
{
    return m1; // to be completed
}

/*! Returns a new Matrix that is equal to 'm1*m2'. */
template<typename T>
MatrixT<T> operator*(const MatrixT<T>& m1,const MatrixT<T>& m2)
{
    return m1; // to be completed
}

#endif
