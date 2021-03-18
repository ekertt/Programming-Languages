#include "MatrixT.h"

using Matrix = MatrixT<double>;

// /*! Represents a 2 dimensional matrix of doubles.*/
// class Matrix
// {
//     int m_rows, m_cols;
//     std::vector<double> m_data;

// public:
//     // constructors
//     Matrix() : m_rows{0}, m_cols{0} {}
//     Matrix(int rows, int cols) : m_rows{rows}, m_cols{cols}, m_data(rows * cols) {}

//     std::vector<double> &vec() { return m_data; }
//     const std::vector<double> &vec() const { return m_data; }

//     int nr_rows() const { return m_rows; }
//     int nr_cols() const { return m_cols; }
//     double &operator()(int r, int c) { return m_data[r * m_cols + c]; }
//     const double &operator()(int r, int c) const { return m_data[r * m_cols + c]; }

//     friend std::istream &operator>>(std::istream &is, Matrix &matrix); // give operator access to private variables
// };

// /*! Reads a Matrix from 'is' stream. */
// std::istream &operator>>(std::istream &is, Matrix &matrix)
// {
//     std::vector<double> data;
//     std::string line;
//     std::string tokenEntry;
//     int cols = 0;
//     int rows = 0;

//     while (std::getline(is, line))
//     {
//         rows++;
//         std::stringstream stringStream(line);

//         while (std::getline(stringStream, tokenEntry, ','))
//         {
//             trim(tokenEntry);
//             data.push_back(atof(tokenEntry.c_str()));
//         }
//     }

//     cols = data.size() / rows;

//     matrix.m_rows = rows;
//     matrix.m_cols = cols;
//     matrix.m_data = data;

//     return is;
// }

// /*! Writes Matrix 'matrix' to 'os' stream. */
// std::ostream &operator<<(std::ostream &os, const Matrix &matrix)
// {
//     int rows = matrix.nr_rows();
//     int columns = matrix.nr_cols();

//     for (int x = 0; x < rows; x++)
//     {
//         for (int y = 0; y < columns; y++)
//         {
//             os << matrix(x, y);

//             if (y < columns - 1)
//             {
//                 os << ',';
//             }
//         }

//         if (x < rows - 1)
//         {
//             os << "\n";
//         }
//     }

//     return os;
// }

// /*! Returns a new Matrix that is the negation of 'matrix' */
// Matrix operator-(const Matrix &matrix)
// {
//     int rows = matrix.nr_rows();
//     int columns = matrix.nr_cols();

//     Matrix newMatrix(rows, columns);

//     for (int x = 0; x < rows; x++)
//     {
//         for (int y = 0; y < columns; y++)
//         {
//             newMatrix.vec()[y] = matrix.vec()[y] * -1;
//         }
//     }

//     return newMatrix;
// }

// /*! Returns a new Matrix that is the transpose of 'matrix' */
// Matrix transpose(const Matrix &matrix)
// {
//     int rows = matrix.nr_rows();
//     int columns = matrix.nr_cols();
//     int count = 0;

//     Matrix newMatrix(columns, rows);

//     for (int x = 0; x < columns; x++)
//     {
//         int c = 0;
//         for (int y = 0; y < rows; y++)
//         {
//             newMatrix.vec()[count] = matrix.vec()[x + c];
//             count += 1;
//             c += columns;
//         }
//     }

//     return newMatrix;
// }

// /*! Returns a new Matrix that is equal to 'm1+m2'. */
// Matrix operator+(const Matrix &m1, const Matrix &m2)
// {
//     int rows = m1.nr_rows();
//     int columns = m1.nr_cols();

//     Matrix newMatrix(rows, columns);

//     for (int x = 0; x < rows; x++)
//     {
//         for (int y = 0; y < columns; y++)
//         {
//             newMatrix.vec()[y] = m1.vec()[y] + m2.vec()[y];
//         }
//     }

//     return newMatrix;
// }

// /*! Returns a new Matrix that is equal to 'm1-m2'. */
// Matrix operator-(const Matrix &m1, const Matrix &m2)
// {
//     int rows = m1.nr_rows();
//     int columns = m1.nr_cols();

//     Matrix newMatrix(rows, columns);

//     for (int x = 0; x < rows; x++)
//     {
//         for (int y = 0; y < columns; y++)
//         {
//             newMatrix.vec()[y] = m1.vec()[y] - m2.vec()[y];
//         }
//     }

//     return newMatrix;
// }

// /*! Returns a new Matrix that is equal to 'm1*m2'. */
// Matrix operator*(const Matrix &m1, const Matrix &m2)
// {
//     int firstRows = m1.nr_rows();
//     int secondRows = m2.nr_rows();
//     int firstColumns = m1.nr_cols();
//     int secondColumns = m2.nr_cols();

//     std::vector<double> data;
//     Matrix newMatrix(firstRows, secondColumns);

//     if (firstColumns != secondRows)
//     {
//         throw new Evaluator_exception("Invalid dimensions");
//     }

//     for (int x = 0; x < firstRows; x++)
//     {
//         for (int y = 0; y < secondColumns; y++)
//         {
//             double sum = m1(x, 0) * m2(0, y);
//             for (int z = 1; z < firstColumns; z++)
//             {
//                 sum += m1(x, z) * m2(z, y);
//             }
//             data.push_back(sum);
//         }
//     }
//     newMatrix.vec() = data;

//     return newMatrix;
// }

// #endif
