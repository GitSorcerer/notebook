-- to be compatible with aliyun redis,
-- we cannot use `local key = KEYS[1]` to reuse thekey
local limit = tonumber(ARGV[1])
local window = tonumber(ARGV[2])
-- incrbt key 1 => key visis++
local current = redis.call("INCRBY", KEYS[1], 1)
-- 如果是第一次访问，设置过期时间 => TTL = window size
-- 因为是只限制一段时间的访问次数
if current == 1 then
    redis.call("expire", KEYS[1], window)
    return 1
elseif current < limit then
    return 1
elseif current == limit then
    return 2
else
    return 0
end