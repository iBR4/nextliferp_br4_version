loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')
addEvent("onDepositAllHit",true)
addEvent("onWithdrawAllHit",true)
addEvent("onWithdrawHit",true)
addEvent("onDepositHit",true)
function onPlayerLogin(per,cur)
account = getPlayerAccount(source)
money = getAccountData(account,"Roleplay:bank_balance")
setElementData(source,"Roleplay:bank_balance",money)
end
addEventHandler("onPlayerLogin",root,onPlayerLogin)
function onPlayerLogout()
account = getPlayerAccount(source)
money = getElementData(source,"Roleplay:bank_balance")
setAccountData(account,"Roleplay:bank_balance",money)
end
addEventHandler("onPlayerQuit",root,onPlayerLogout)
addEventHandler("onWithdrawAllHit",root,function(bm)
givePlayerMoney(source,tonumber(bm))
end
)
addEventHandler("onDepositAllHit",root,function(rm)
takePlayerMoney(source,tonumber(rm))
end
)
addEventHandler("onDepositHit",root,function(money)
takePlayerMoney(source,tonumber(money))
end
)
addEventHandler("onWithdrawHit",root,function(money)
givePlayerMoney(source,tonumber(money))
end
)