local function aggregate_stats(map,rec)
  if map[rec['region']]==0
  then
    map[rec['region']]=1
  else
    map[rec['region']] = map[rec['region']]+1
  end
  return map
end

local function reduce_stats(a,b)
  a.n=a.n+b.n
  a.s=a.s+b.s
  a.e=a.e+b.e
  a.w=a.w+b.w

  return a
end

function sum(stream)
  -- Process incoming record stream and pass it to aggregate function, then to reduce function
  --   NOTE: aggregate function aggregate_stats accepts two parameters:
  --    1) A map that contains four variables to store number-of-users counter for north, south, east and west regions with initial value set to 0
  --    2) function name aggregate_stats -- which will be called for each record as it flows in
  -- Return reduced value of the map generated by reduce function reduce_stats

 return stream : aggregate(map{n=0, s=0, e=0, w=0}, aggregate_stats) : reduce(reduce_stats)
 end
