#! /usr/bin/python3

from sys import argv

w = int( argv[1] ) if len( argv ) == 2 else 16
h = ( '  +', '--+' )
v = ( '   ', '  |', 'OO ', 'OO|' )

print( '+' + '--+' * w )
while True:
    try:
        line=input()
    except EOFError:
        break
    print( '|', *[ v[int( c ) >> 1 & 3] for c in line ], sep='' )
    print( '+', *[ h[int( c ) & 1] for c in line ], sep='' )

