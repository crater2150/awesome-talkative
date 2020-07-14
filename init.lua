local naughty = require("naughty")
local awful = require("awful")

local talkative = { loggers = {}, mt = {}}

local defaults = {}
local settings = {}

defaults.loggers = { }
defaults.defaultlevel = 0

for key, value in pairs(defaults) do
    settings[key] = value
end

talkative.level = {
	ERROR = 3,
	WARNING = 2,
	NORMAL = 1,
	DEBUG = 0
}

local function loglv(msg, level)
	for _,logger in ipairs(settings.loggers) do
		logger(msg, level)
	end
end

function talkative.dbg(msg)
	loglv(msg, 0)
end

function talkative.log(msg)
	loglv(msg, 1)
end

function talkative.warn(msg)
	loglv(msg, 2)
end

function talkative.error(msg)
	loglv(msg, 3)
end

function talkative.add_logger(logger, level)
	if level == nil then
		level = settings.defaultlevel
	end
	table.insert(settings.loggers, function(msg, severity)
		if severity >= level then
			logger(msg, severity)
		end
	end)
end

function talkative.loggers.naughty(msg, severity)
	if severity == talkative.level.WARNING then
		msg = "<span color=\"#ff6\">".. msg .. "</span>"
	elseif severity == talkative.level.ERROR then
		msg = "<span color=\"#f66\">".. msg .. "</span>"
	end
	naughty.notify({ text = msg })
end

function talkative.spawn(command)
	talkative.dbg("Executing: " .. command)
	awful.spawn(command)
end

function talkative.loggers.stdio(msg, severity)
	print(msg)
end


talkative.mt.__call = function(t,message) talkative.log(message) end

return setmetatable(talkative, talkative.mt)
