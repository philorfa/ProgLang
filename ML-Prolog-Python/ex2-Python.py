import sys

def process(f):
        gridzero = f.readlines()
        solve(gridzero)

def backtracking(grid, posx, posy,rows,cols):
    moves=0
    i = posx
    j = posy
    symbols = [0 for i in range(rows * cols)]
    while (grid[i][j] != 1):
        if (i != rows - 1):
            if (grid[i + 1][j] - grid[i][j] == -1):
                symbols[moves] = 'U'
                i = i + 1
                moves = moves + 1
                continue
        if (j != 0):
            if (grid[i][j - 1] - grid[i][j] == -1):
                symbols[moves] = 'R'
                j = j - 1
                moves = moves + 1
                continue
        if (j != cols - 1):
            if (grid[i][j + 1] - grid[i][j] == -1):
                symbols[moves] = 'L'
                j = j + 1
                moves = moves + 1
                continue
        if (i != 0):
            if (grid[i - 1][j] - grid[i][j] == -1):
                symbols[moves] = 'D'
                i = i - 1
                moves = moves + 1
                continue
    if (moves == 0):
        print('stay', end='', flush=True)
    return (symbols,moves)

def expandgrid(grid, sources, newone, time, xdim, ydim, cont,rows,cols):
    moves = 0
    if cont:
        return grid
    else:
        for i in range(sources - 1, sources - newone - 1, -1):
            if xdim[i] != 0:
                if (grid[xdim[i] - 1][ydim[i]] == 0) & (grid[xdim[i] - 1][ydim[i]] != -1):
                    grid[xdim[i] - 1][ydim[i]] = time
                    moves = moves + 1
                    xdim[sources - 1 + moves] = xdim[i] - 1
                    ydim[sources - 1 + moves] = ydim[i]
            if ydim[i] != 0:
                if (grid[xdim[i]][ydim[i] - 1] == 0) & (grid[xdim[i]][ydim[i] - 1] != -1):
                    grid[xdim[i]][ydim[i] - 1] = time
                    moves = moves + 1
                    xdim[sources - 1 + moves] = xdim[i]
                    ydim[sources - 1 + moves] = ydim[i] - 1
            if xdim[i] != rows - 1:
                if (grid[xdim[i] + 1][ydim[i]] == 0) & (grid[xdim[i] + 1][ydim[i]] != -1):
                    grid[xdim[i] + 1][ydim[i]] = time
                    moves = moves + 1
                    xdim[sources - 1 + moves] = xdim[i] + 1
                    ydim[sources - 1 + moves] = ydim[i]
            if ydim[i] != cols - 1:
                if (grid[xdim[i]][ydim[i] + 1] == 0) & (grid[xdim[i]][ydim[i] + 1] != -1):
                    grid[xdim[i]][ydim[i] + 1] = time
                    moves = moves + 1
                    xdim[sources - 1 + moves] = xdim[i]
                    ydim[sources - 1 + moves] = ydim[i] + 1
        if moves == 0:
            cont = True
        x = sources + moves
        time = time + 1
        return expandgrid(grid, x, moves, time, xdim, ydim, cont,rows,cols)


def solve(gridzero1):
    gridzero = [row.rstrip('\n') for row in gridzero1]

    rows = len(gridzero)
    cols = len(gridzero[0])

    gridcat = [[0 for y in range(cols)] for x in range(rows)]
    gridwater = [[0 for y in range(cols)] for x in range(rows)]
    waterx = [0 for i in range(rows * cols)]
    watery = [0 for i in range(rows * cols)]
    catx = [0 for i in range(rows * cols)]
    caty = [0 for i in range(rows * cols)]
    posx = 0
    posy = 0
    ptime = 0
    sources = 0
    cats = 0
    moves = 0
    fl = False

    for xi in range(rows):
        for yi in range(cols):
            if gridzero[xi][yi] == '.':
                gridcat[xi][yi] = 0
                gridwater[xi][yi] = 0
            elif gridzero[xi][yi] == 'W':
                gridcat[xi][yi] = 0
                gridwater[xi][yi] = 1
                waterx[sources] = xi
                watery[sources] = yi
                sources = sources + 1
            elif gridzero[xi][yi] == 'A':
                gridcat[xi][yi] = 1
                gridwater[xi][yi] = 0
                catx[cats] = xi
                caty[cats] = yi
                cats = cats + 1
            elif gridzero[xi][yi] == 'X':
                gridcat[xi][yi] = -1
                gridwater[xi][yi] = -1

    begin = 2
    gridcat = expandgrid(gridcat, cats, cats, begin, catx, caty, False,rows,cols)
    gridwater = expandgrid(gridwater, sources, sources, begin, waterx, watery, False,rows,cols)

    for i in range(rows):
        for j in range(cols):
            if (gridwater[i][j] == 0) & (gridcat[i][j] > 0):
                posx = i
                posy = j
                print("infinity")
                fl = True
                break
            elif gridwater[i][j] > gridcat[i][j]:
                if gridwater[i][j] > ptime:
                    posx = i
                    posy = j
                    ptime = gridwater[i][j]
        if fl:
            break

    if (not fl):
        print(ptime - 2)
    symbols,moves = backtracking(gridcat, posx, posy,rows,cols)
    if moves != 0:
        for i in range(moves - 1, -1, -1):
            print(symbols[i], end='', flush=True)





if __name__ == "__main__":
    if len(sys.argv) > 1:
        with open(sys.argv[1], "rt") as f:
            process(f)
    else:
        process(sys.stdin)        