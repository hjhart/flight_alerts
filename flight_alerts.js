var page, url;
page = require("webpage").create();
page.settings.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24";
url = "http://www.google.com/flights/#search;f=SFO;t=LAX;d=2012-07-05;r=2012-07-12";
console.log("Fetching page: " + url);
page.open(url, function(status) {
  var results;
  if (status !== "success") {
    console.log("Unable to access network");
  } else {
    page.render("./test.png");
    results = page.evaluate(function() {
      var i, list, pizza;
      console.log(document.querySelectorAll("body").innerText);
      list = document.querySelectorAll(".GLUJYJKK2B");
      pizza = [];
      i = void 0;
      i = 0;
      while (i < list.length) {
        pizza.push(list[i].innerText);
        i++;
      }
      return pizza;
    });
    console.log(results.join("\n"));
  }
  return phantom.exit();
});