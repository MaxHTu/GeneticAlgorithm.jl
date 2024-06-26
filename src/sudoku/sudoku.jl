# variables
global n = 9*9 # size of sudoku
global exp = [1,2,3,4,5,6,7,8,9] # array of expected values
global k = 0 # number of values that need to be filled
global j = 0 # number of values that are already filled

# functions

function baseSudoku(i)
    if i == 1
        r1 = [0,4,8,2,0,0,0,0,1]
	    r2 = [1,0,0,3,8,4,7,2,6]
	    r3 = [3,0,0,7,0,1,9,4,8]
	    r4 = [0,7,2,6,4,5,1,8,0]
	    r5 = [8,0,0,0,0,2,4,0,0]
	    r6 = [0,0,0,0,0,0,0,0,7]
	    r7 = [0,8,4,0,0,0,3,0,0]
	    r8 = [6,0,0,4,1,0,0,0,2]
	    r9 = [0,0,3,0,0,0,0,7,4]

        s = stack((r1,r2,r3,r4,r5,r6,r7,r8,r9))'

        return s
    end
    r1 = [0,3,0,0,7,0,0,5,0]
	r2 = [5,0,0,1,0,6,0,0,9]
	r3 = [0,0,1,0,0,0,4,0,0]
	r4 = [0,9,0,0,5,0,0,6,0]
	r5 = [6,0,0,4,0,2,0,0,7]
	r6 = [0,4,0,0,1,0,0,3,0]
	r7 = [0,0,2,0,0,0,8,0,0]
	r8 = [9,0,0,3,0,5,0,0,2]
	r9 = [0,1,0,0,2,0,0,7,0]

    s = stack((r1,r2,r3,r4,r5,r6,r7,r8,r9))'

    return s
end

function initialState(s)
    g = copy(s)
	for x in range(1,9)
		for y in range(1,9)
			if s[x,y] == 0
				t = 1:9[1:9 .∉ Ref(g[x,:])]
				g[x,y] = rand(t)
			end
		end
	end
	return g
end