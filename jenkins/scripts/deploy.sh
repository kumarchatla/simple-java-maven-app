curl --cookie-jar cookie.txt "https://console.deployhub.com/dmadminweb/API/login?user=developer&pass=any"
curl -b cookie.txt "https://console.deployhub.com/dmadminweb/API/deploy/HelloWorldApp%3B1/GLOBAL.Linux%20Academy.DevSecOps.My%20Pipeline.Development.Dev?task=Deploy%20to%20Dev&wait=n"
