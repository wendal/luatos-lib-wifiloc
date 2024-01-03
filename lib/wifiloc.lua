
--[[
@module wifiloc
@summary wifi定位库
@version 1.0.0
@date    2024.01.03
@author  wendal
@tag LUAT_USE_WLAN
@usage
-- 具体用法请查阅demo
]]

local wifiloc = {}

--[[
请求一次定位
@api wifiloc.req(results, opts)
@table wifi扫描的结果
@table 配置参数
@return table 返回的定位信息,失败返回nil
@usage
-- 注意, 本API需要在task中调用, 为同步函数
-- 返回的结果类似于 {"lng":1122310250,"lat":244067721}
]]
function wifiloc.req(results, opts)
    if not opts then
        opts = {}
    end
    log.info("scan", "results", #results)
    if #results < 3 then
        log.info("wifi", "至少3个wifi信息才能查询")
        return
    end
    local t = {}
    t["key"] = opts.key or "freedemo"
    t["unique_id"] = opts.unique_id or mcu.unique_id():toHex()
    if mobile then
        t["imei"] = mobile.imei()
        t["iccid"] = mobile.iccid()
    end
    local wifis = {}
    t["wifis"] = wifis

    for k,v in pairs(results) do
        -- log.info("scan", v["ssid"], v["rssi"], (v["bssid"]:toHex()))
        local tmp = {}
        tmp["mac"] = v["bssid"]:toHex()
        tmp["rssi"] = v["rssi"]
        -- tmp["ssid"] = v["ssid"]
        table.insert(wifis, tmp)
    end
    -- local rbody = (json.encode(t))
    -- log.info("请求的内容", rbody)
    -- sys.taskInit(function()
        -- log.info("执行查询")
        local code, headers, body = http.request("POST", "http://wifi.air32.cn/wifi", nil, (json.encode(t))).wait()
        if code == 200 and body and #body > 10 then
            -- log.info("wifiloc", "查询成功", body)
            return json.decode(body)
        else
            log.info("wifiloc", "查询失败", code, body)
            return
        end
    -- end)
end

return wifiloc
