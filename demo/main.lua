--[[
wifi定位演示
]]

-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "wifidemo"
VERSION = "1.0.0"

log.info("main", PROJECT, VERSION)

-- 一定要添加sys.lua !!!!
sys = require("sys")
sysplus = require("sysplus")

-- 用户代码已开始---------------------------------------------

require "netready"
require "demo"

-- 用户代码已结束---------------------------------------------

-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!
