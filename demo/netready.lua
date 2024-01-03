

-- 统一联网函数
sys.taskInit(function()
    -----------------------------
    -- 统一联网函数, 可自行删减
    ----------------------------
    if wlan and wlan.connect then
        -- wifi 联网, ESP32系列均支持, 要根据实际情况修改ssid和password!!
        local ssid = _G.ssid or "luatos1234"
        local password = _G.password or "12341234"
        log.info("wifi", ssid, password)
        -- TODO 改成自动配网
        wlan.init()
        wlan.setMode(wlan.STATION) -- 默认也是这个模式,不调用也可以
        wlan.connect(ssid, password, 1)
    elseif mobile then
        -- EC618系列, 如Air780E/Air600E/Air700E
        -- mobile.simid(2) -- 自动切换SIM卡, 按需启用
        -- 模块默认会自动联网, 无需额外的操作
        wlan.init()
    else
        -- 其他不认识的bsp, 循环提示一下吧
        while 1 do
            sys.wait(1000)
            log.info("bsp", "本bsp可能未适配网络层, 请查证")
        end
    end
    -- 默认都等到联网成功
    sys.waitUntil("IP_READY")
    sys.publish("net_ready")
end)
