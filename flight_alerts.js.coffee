page = require("webpage").create()
page.settings.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
url = "http://www.google.com/flights/#search;f=SFO;t=LAX;d=2012-07-02;r=2012-07-08"

page.onConsoleMessage = (msg) ->
  console.log msg

page.open url, (status) ->
  if status isnt "success"
    console.log JSON.stringify({"status":"Error", "reason":"Network error."})
    phantom.exit()
  else
    page.render "./last_result.png"
    page_content = page.content
    if page_content.length < 200000
      console.log JSON.stringify({"status":"Error", "reason":"The page that was returned was not fully added"})
      phantom.exit()
    page.injectJs "jquery.min.js"
    page.evaluate ->
      to_military_time = (time_string) ->
        m = time_string.match(/(\d+):(\d+) ([ap])m/)
        m[1] = m[1] % 12
        m[1] += 12  if m[3] is "p"
        m[1] = "0" + m[1]  if m[1] < 10
        m[1] + ":" + m[2]

      magical_regexp = /(\d{1,2}:\d{1,2} [ap]m)(\dh)(\d{1,2}:\d{1,2} [ap]m)(.*)from.\$(\d+)/
      list = document.querySelectorAll(".GLUJYJKK2B")
      flight_rows = []
      i = 0
      while i < list.length
        result = {}
        content = list[i].innerText
        matches = content.match(magical_regexp)
        if matches
          result["takeoff_time"] = to_military_time(matches[1])
          result["length"] = matches[2]
          result["landing_time"] = to_military_time(matches[3])
          result["airline"] = matches[4]
          result["price_in_us_dollars"] = matches[5]
          flight_rows.push result
        i++

      if(flight_rows.length == 0)
        console.log JSON.stringify({"status":"Error", "reason":"No results were found."})
        phantom.exit()
      else
        console.log(JSON.stringify({"status":"Success", "results": flight_rows}))
  phantom.exit()