--non tail-recursive
local function multiply0(n, a)
	print('n: ' .. n .. ' a: ' .. a)
	if n == 1 then  --[[error('have a peek', a) --[[--]] return a end
	return a + multiply0(n - 1, a)
end


print('multiply0 no tail recursion')
stat, ret = pcall(multiply0, 10 , 5)
print(ret)
print(stat)
print('10*5 = ' .. ret)


--multiply0 wit tail recursion via accumulator acc
--complexity = O(n)
local function multiply0tr_acc(n, a, acc)
	--print('n: ' .. n .. ' a: ' .. a .. ' acc: ' .. acc)
	if n == 1 then  --[[error('have a peek', acc)--[[--]] return acc end
	return multiply0tr_acc(n - 1, a, a + acc)
end

--tail-recursive multiply0
local function multiply0tr(n, a)
	return multiply0tr_acc(n, a, 0)
end


print('multiply0 with tail recursion')
res, stat = pcall(multiply0tr, 10, 5)
print('10*5 = ' .. tostring(res))
--res, stat = pcall(multiply0tr, 123456789, 123456789)
--
--print('big multiply = ' .. tostring(stat))

print('\n\nHere is an example of varargs usage, avoiding the additional function call')

--multiply0 wit tail recursion via accumulator acc and varargs va
--it would appear that multiply0 with the extra call may be faster due to less branching (depends on interpreter optimization)
--and assignment, only tests will tell ;)
local function multiply0tr_accva(n, a, acc)
	local acc = acc or 0
	--print('n: ' .. n .. ' a: ' .. a .. ' acc: ' .. acc)
	if n == 1 then  --[[error('have a peek')--]] return acc end
	return multiply0tr_accva(n - 1, a, a + acc)
end

print('12* 12 = ' .. multiply0tr_accva(12, 12) )
--print('123456789* 123456789 = ' .. multiply0tr_accva(123456789, 123456789) )
--
local function odd(n)
	return n & 0x1
end
local function half(n)
	return n >> 1
end
local function multiply1(n, a)
	if n == 1 then return a end
	local res = multiply1(half(n), a + a)
	if odd(n) then res = res + a end
	return res
end

print('multiply1 i.e. Russian Peasant\'s Algorithm')
print('a == n == 123456789')
stat, res = pcall(multiply1, 123456789, 123456789) 
--correct result is 
--ramzi:GenericProgramming$ echo "123456789*123456789" |bc -l 
--15241578750190521
print(tostring(stat))
print(tostring(res))

--optimal addition chains for n < 100
--n == 0 => return 0
--n == 1 => return a
--n == 2 => return a + a
--n == 3 => return a + a + a
--n == 4 => return (a + a) + (a + a)
--n == 5 => return (a+a) + (a+a) +a
--n == 6 == 2 * 3 == a * 2*3 (!!)
--b = a + a (+1)
--c = b + a (+1)
--d = c + b (+1) == 5*a
--e = d + a (+1) == 6*a
--b = a + a == 2*a
--c = b + b  == 4*a
--d = c + b == 6*a (+3) 

local function multiply_by_2(a)
	return a + a
end

local function mutliply_by_3(a) -- 2 additions
	return a + multiply_by_2(a)
end

local function multiply_by_4(a) -- 2 additions
	return multiply_by_2(a + a)
end

local function multiply_by_5(a) -- 3 additions
	return a + multiply_by_4(a)
end

local function multiply_by_6(a) -- 3 additions
	local z = multiply_by_2(a)
	return multiply_by_2(z) + z
end

local function multiply_by_7(a) -- (+4)
	local d = multiply_by_6(a) + a
	return d
end

local function multiply_by_8(a) -- (+3!)
	return multiply_by_4(a + a)
end


--the pattern ? multiply_by_x <=> multiply_by_x-1 + x
--if x = 0 => 0
--x = 1 => 0 + x
