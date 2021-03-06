/*
Author: Tim van Ekert (13635565)
Study: Software Engineering HvA, Pre master SE UvA
Version: 1
Description: This program defines a generic matrix. It is supposed to extend the Matrix.h file to change the doubles into generic types.
*/

#ifndef MATRIXT_INCLUDED
#define MATRIXT_INCLUDED

#include <vector>
#include <iostream>

#include "evaluator_exception.h"
#include "evaluator_string_tools.h"

/*! Represents a 2 dimensional matrix of template type T. */
template <typename T>
class MatrixT
{
    int m_rows, m_cols;
    std::vector<T> m_data;

public:
    // constructors
    MatrixT() : m_rows{0}, m_cols{0} {}
    MatrixT(int rows, int cols) : m_rows{rows}, m_cols{cols}, m_data(rows * cols) {}

    std::vector<T> &vec() { return m_data; }
    const std::vector<T> &vec() const { return m_data; }

    int nr_rows() const { return m_rows; }
    int nr_cols() const { return m_cols; }
    T &operator()(int r, int c) { return m_data[r * m_cols + c]; }
    const T &operator()(int r, int c) const { return m_data[r * m_cols + c]; }

    template <typename T2>
    friend std::istream &operator>>(std::istream &is, MatrixT<T2> &matrix); // give operator access to private variables
};

/*! Reads a Matrix from 'is' stream. */
template <typename T>
std::istream &operator>>(std::istream &is, MatrixT<T> &matrix)
{
    std::vector<T> data;
    std::string line;
    std::string tokenEntry;
    int cols = 0;
    int rows = 0;

    while (std::getline(is, line))
    {
        rows++;
        std::stringstream stringStream(line);

        while (std::getline(stringStream, tokenEntry, ','))
        {
            trim(tokenEntry);
            data.push_back(atof(tokenEntry.c_str()));
        }
    }

    cols = data.size() / rows;

    matrix.m_rows = rows;
    matrix.m_cols = cols;
    matrix.m_data = data;

    return is; // to be completed
}

/*! Writes Matrix 'matrix' to 'os' stream. */
template <typename T>
std::ostream &operator<<(std::ostream &os, const MatrixT<T> &matrix)
{
    int rows = matrix.nr_rows();
    int columns = matrix.nr_cols();

    for (int x = 0; x < rows; x++)
    {
        for (int y = 0; y < columns; y++)
        {
            os << matrix(x, y);

            if (y < columns - 1)
            {
                os << ',';
            }
        }

        if (x < rows - 1)
        {
            os << "\n";
        }
    }
    return os; // to be completed
}

/*! Returns a new Matrix that is the negation of 'matrix'. */
template <typename T>
MatrixT<T> operator-(const MatrixT<T> &matrix)
{
    int rows = matrix.nr_rows();
    int columns = matrix.nr_cols();

    MatrixT<T> newMatrix(rows, columns);

    for (int x = 0; x < rows; x++)
    {
        for (int y = 0; y < columns; y++)
        {
            newMatrix(x, y) = -matrix(x, y);
        }
    }
    return newMatrix; // to be completed
}

/*! Returns a new Matrix that is the transpose of 'matrix'. */
template <typename T>
MatrixT<T> transpose(const MatrixT<T> &matrix)
{
    int rows = matrix.nr_rows();
    int columns = matrix.nr_cols();
    int count = 0;

    MatrixT<T> newMatrix(columns, rows);

    for (int x = 0; x < columns; x++)
    {
        int c = 0;
        for (int y = 0; y < rows; y++)
        {
            newMatrix.vec()[count] = matrix.vec()[x + c];
            count += 1;
            c += columns;
        }
    }

    return newMatrix; // to be completed
}

/*! Returns a new Matrix that is equal to 'm1+m2'. */
template <typename T>
MatrixT<T> operator+(const MatrixT<T> &m1, const MatrixT<T> &m2)
{
    int rows = m1.nr_rows();
    int columns = m1.nr_cols();

    MatrixT<T> newMatrix(rows, columns);

    for (int x = 0; x < rows; x++)
    {
        for (int y = 0; y < columns; y++)
        {
            newMatrix(x, y) = m1(x, y) + m2(x, y);
        }
    }
    return newMatrix; // to be completed
}

/*! Returns a new Matrix that is equal to 'm1-m2'. */
template <typename T>
MatrixT<T> operator-(const MatrixT<T> &m1, const MatrixT<T> &m2)
{
    int rows = m1.nr_rows();
    int columns = m1.nr_cols();

    MatrixT<T> newMatrix(rows, columns);

    for (int x = 0; x < rows; x++)
    {
        for (int y = 0; y < columns; y++)
        {
            newMatrix(x, y) = m1(x, y) - m2(x, y);
        }
    }
    return newMatrix; // to be completed
}

/*! Returns a new Matrix that is equal to 'm1*m2'. */
template <typename T>
MatrixT<T> operator*(const MatrixT<T> &m1, const MatrixT<T> &m2)
{
    int firstRows = m1.nr_rows();
    int secondRows = m2.nr_rows();
    int firstColumns = m1.nr_cols();
    int secondColumns = m2.nr_cols();

    std::vector<T> data;
    MatrixT<T> newMatrix(firstRows, secondColumns);

    if (firstColumns != secondRows)
    {
        throw new Evaluator_exception("Invalid dimensions");
    }

    for (int x = 0; x < firstRows; x++)
    {
        for (int y = 0; y < secondColumns; y++)
        {
            T sum = m1(x, 0) * m2(0, y);
            for (int z = 1; z < firstColumns; z++)
            {
                sum += m1(x, z) * m2(z, y);
            }
            data.push_back(sum);
        }
    }
    newMatrix.vec() = data;
    return newMatrix; // to be completed
}

#endif
