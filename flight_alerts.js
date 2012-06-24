var page, url;
var takeoff_time, landing_time, length, airline, price_in_us_dollars

page = require("webpage").create();
page.settings.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24";
url = "http://www.google.com/flights/#search;f=SFO;t=LAX;d=2012-07-05;r=2012-07-12";
console.log("Fetching page: " + url);
page.onConsoleMessage = function (msg){
    console.log(msg);
};

page.open(url, function(status) {
  var results;
  if (status !== "success") {
    console.log("Unable to access network");
  } else {
    page.render("./test.png");
    var page_content = page.content
    if (page_content.length <  200000) {
      console.log("*********************************************************************************************")
      console.log("We can assume based on the page size that the whole page was not fetched / executed properly.")
      console.log("*********************************************************************************************")
    }
    results = page.evaluate(function() {
      var i, list, flight_rows;
      var magical_regexp = /(\d{1,2}:\d{1,2} [ap]m)(\dh)(\d{1,2}:\d{1,2} [ap]m)(.*)from.\$(\d+)/
      list = document.querySelectorAll(".GLUJYJKK2B");
      console.log("Found how many selectors? " + list.length);
      flight_rows = [];
      i = 0;
      while (i < list.length) {
        var result = {}
        var content = list[i].innerText
        var matches = content.match(magical_regexp)
        if(matches) {
          result["takeoff_time"] = matches[1]
          result["length"] = matches[2]
          result["landing_time"] = matches[3]
          result["airline"] = matches[4]
          result["price_in_us_dollars"] = matches[5]
          flight_rows.push(result);
        }
        i++;
      }
      return flight_rows;
    });
    console.log(results.join("\n"));
  }
  return phantom.exit();
});