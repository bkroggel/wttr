# Wttr Forecast Widget
for Übersicht `http://tracesof.net/uebersicht/`  
Version: `1.0`  
Last Updated: `10/26/2017`

![](https://user-images.githubusercontent.com/11707221/32011802-1f636834-b9b6-11e7-928c-1e80f25d3b74.png)


Wttr Forecast is a multi-location weather widget build
for [Übersicht](http://tracesof.net/uebersicht/) (MacOS).
Wttr Forecast stores all weather information locally on your device
and allows you to access forecasts even when you are offline.

---

## Features

<img src="https://user-images.githubusercontent.com/11707221/32046767-3b04baa0-ba44-11e7-9bde-6153cb50e363.gif" width="250px"></img>

- [x] makes use of the DarkSky API with a global coverage of nearly any location
- [x] allows you to add multiple location without adding more and more bloat to your screen
- [x] displays not just the current weather situation but also the forecast for upcoming days
- [x] loaded weather forecast gets stored on the local machine so even if your internet connection fails the Wttr widget will still display the last available information
- [x] customizable so you can easily set your desired language, unit or color preferences

**Important information:**   
In order to use the arrows or navigation dots to switch between your different locations you need to choose an `interaction shortcut` in the Übersicht preferences.


## HowTo:

<img src="https://user-images.githubusercontent.com/11707221/32011803-1f895530-b9b6-11e7-8154-f07e6379e314.png" width="450px"></img>

In order to set up the widget properly you need to add the DarkSky API (forecasting provider) by yourself.
The following steps will guide you through these steps:

1. Open: https://darksky.net/dev
2. Log in or Sign up if you haven't created an account yet
3. Get your secret key and add it below to the `apiKey` section
   (the key needs to be put in quotation marks)

### Settings:

| Key        | Description           |
| ------------- |:-------------|
| `apiKey`      | add your personal DarkSky secret API key in order to download weather forecast information |
| `uni`      | Return weather conditions in requested units: <ul><li>`auto`: automatically select units based on geographic location</li><li>`ca`: same as si</li><li>`uk2`: same as si</li><li>`us`: Imperial units</li><li>`si`: SI units (more: https://darksky.net/dev/docs)</li></ul>|
|`language`   | desired language in which summaries will get display (more: https://darksky.net/dev/docs)  |
|`accent`   | accent color  |
| `refreshFrequency`   | sets refresh rate of widget, change value outside of brackets to modify number of minutes before freshly updated weather forecasting information appearance on your screen</br>(remember: Free tier of DarkSky.io allows up to 1000 refresh calls per day) |

-----

### Location:
Adding locations follows an easy to understand principle:

1. create an id for your location (e.g. `lnd`)
2. add a name to your location which later will be displayed on your widget (e.g. `London, G`)
3. add 'Latitude' as well as 'Longitude' information (e.g. `51.5287718` and `-0.2416814`)

you can grab those information from [Google Maps](https://maps.google.com):
1. open [maps.google.com](https://maps.google.com)
2. search for your desired location
3. get the URL:
        https://www.google.com/maps/place/London,+United+Kingdom/@51.5287718,-0.2416814,11z/
                you can find the important information here -->   ^^^^^^^^^^ ^^^^^^^^^^


all in all the `location:` section will look like the following:

    location: #<-- do not remove this part
      lnd:
        name: 'London, GB'
        lat: 51.5287718
        lng: -0.2416814

every other location can be added just like that:

    location: #<-- do not remove this part
      lnd:
        name: 'London, GB'
        lat: 51.5287718
        lng: -0.2416814
      prs:
        name: 'Paris, FR'
        lat: 48.8589507
        lng: 2.2770202

## Credits

<img src="https://user-images.githubusercontent.com/11707221/32011804-1faa8e6c-b9b6-11e7-809c-601e09618329.png" width="450px"></img>

Based on the <a href="https://github.com/rabad/uebersicht-multiple-locations-weather">Multiple Locations Weather widget</a> by <a href="https://github.com/rabad">Rubén Abad</a>. While major parts of this widget were rewritten it still makes use of the original data access as well as parse functions.

Design-wise this widget is highly influenced by a beautiful <a href="https://dribbble.com/shots/1563616-SimpL-Weather-Widget-PSD">SimpL Weather Widget</a> crafted by the wonderfully talented <a href="https://twitter.com/zramos94">Zahir Ramos</a>. Definitely go and check out his work on <a href="https://dribbble.com/zramos">dribble</a>.

The gorgeous [weather icons](https://github.com/erikflowers/weather-icons/) crafted by [Erik Flowers](http://www.helloerik.com/) can not just be used as standalone icons but also as an easy to implement font. So in case you are wondering what else you could use to display the current weather situation I encourage you to check out the [project site](http://erikflowers.github.io/weather-icons/).

Of course credits, where credits belong - so thank you very much <a href="https://twitter.com/Felx">Felix</a> for creating and maintaining <a href="http://tracesof.net/uebersicht/">Übersicht</a>.

In case of questions, errors, suggestions for an improvement or just to talk about your daily life feel free to get in touch with me or create a pull request and implement your needed functionality.


---
[www.bastiankroggel.com](http://bastiankroggel.com)

| Social | Link |
|:--- |:--- |
|Twitter  |  [@derKroggel](https://twitter.com/derKroggel) |
|Github  |  [bkroggel](www.github.com/bkroggel) |


© 2017 | Bastian Kroggel
