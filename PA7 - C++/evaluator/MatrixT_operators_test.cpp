#include <iostream>
#include <sstream>
using namespace std;

#include "MatrixT.h"

/*! Creates and calls functions/operators on MatrixT<T> for test purposes */
int main()
{
    try
    {

        MatrixT<double> matrix;

        stringstream ss;
        ss<<"1, 2, 3\n";
        ss<<"4, 5, 6\n";
        ss>>matrix;  // operator>>

        cout<<"matrix:\n"<< matrix <<'\n'; // operator<<

        cout<<"-matrix:\n"<< -matrix <<'\n';

        cout<<"transpose(matrix):\n"<< transpose(matrix) <<'\n';

        cout<<"matrix+matrix:\n"<< matrix+matrix <<'\n';

        cout<<"matrix-matrix:\n"<< matrix-matrix <<'\n';

        cout<<"matrix*transpose(matrix):\n"<< matrix*transpose(matrix) <<'\n';
        
    } 
    catch(std::exception& e)
    {
        std::cerr<<"exception caught: "<<e.what()<<'\n';
        exit(1);
    }
    return 0;
}
