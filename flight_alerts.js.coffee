# this is all fucked up

page = require("webpage").create()
page.settings.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
first_thursday = new Date("2012-07-05");
return_date = "2012-07-09"



var firstDay = new Date("2009/06/25");
first_thursday = new Date("2012-07-05");
one_weeks_time_in_seconds = (7 * 24 * 60 * 60 * 1000)
next_thursday = new Date(first_thursday.getTime() + (one_weeks_time_in_seconds));
todays_date = new Date()
is_future_date = false

while week_index <= 10 && !is_future_date
  next_thursday = new Date(first_thursday.getTime() + (week_index * one_weeks_time_in_seconds));
  is_future_date = todays_date < next_thursday
  console.log "it is a future date '#{is_future_date}'"
  
  if is_future_date
    week_index += 1
    
  
    

url = "http://www.google.com/flights/#search;f=SFO;t=LAX;d=#{early_date};r=#{return_date}"

console.log "Fetching page: #{url}"

page.open url, (status) ->
  if status isnt "success"
    console.log "Unable to access network"
  else
    page.render("./test.png")
    results = page.evaluate(->
      console.log document.querySelectorAll("body").innerText
      list = document.querySelectorAll(".GLUJYJKK2B")
      pizza = []
      i = undefined
      i = 0
      while i < list.length
        pizza.push list[i].innerText
        i++
      pizza
    )
    console.log results.join("\n")
  phantom.exit()