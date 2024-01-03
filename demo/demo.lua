
local demo = {}

wifiloc = require "wifiloc"

sys.taskInit(function()
    sys.waitUntil("net_ready")

    if not wlan then
        while 1 do
            log.error("wifiloc", "当前固件不支持wifi扫描或者本芯片没有wifi扫描功能,无法演示")
            sys.wait(1000)
        end
    end

    sys.wait(1000)
    
    while 1 do
        wlan.scan()
        local result = sys.waitUntil("WLAN_SCAN_DONE",60000)
        if result then
            local results = wlan.scanResult()
            log.info("scan", "wifi数量", #results)
            local resp = wifiloc.req(results)
            if resp then
                log.info("wifiloc", "wifi定位成功!!!", json.encode(resp))
                log.info("wifiloc", "经度", resp.lng)
                log.info("wifiloc", "纬度", resp.lat)
            else
                log.info("wifiloc", "wifi定位失败!!!")
            end
        else
            log.info("wifiloc", "扫描wifi信息超时!!!")
        end
        sys.wait(30 * 1000)
    end
end)


return demo
