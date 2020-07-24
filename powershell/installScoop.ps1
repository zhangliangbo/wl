[environment]::setEnvironmentVariable('SCOOP','D:\scoop','User')
$env:SCOOP='D:\scoop'
iex (new-object net.webclient).downloadstring('http://199.232.68.133/lukesampson/scoop/master/bin/install.ps1')
[environment]::setEnvironmentVariable('SCOOP_GLOBAL','D:\ScoopApps','Machine')
$env:SCOOP_GLOBAL='D:\ScoopApps'
pause