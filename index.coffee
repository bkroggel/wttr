# ----------
# Wttr Forecast WIDGET for Übersicht
# Version: 0.1
# Last Updated: 10/25/2017
#
# Wttr Forecast is a multi-location weather widget build
# for Übersicht app (http://tracesof.net/uebersicht/).
# Wttr Forecast stores all weather information locally on your device
# and allows you to access forecasts even when you are offline.
#
# www.bastiankroggel.com
# Twitter: @derKroggel
# Github: www.github.com/bkroggel
# Copyright © 2017 | Bastian Kroggel
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by#
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# ----------

# ----------
# MANUAL:
# 1. open: https://darksky.net/dev
# 2. Log in or Sign up if you haven't created an account yet
# 3. Get your secret key and add it below to the apiKey section
#    (the key needs to be put in quotation marks)
#
# SETTINGS:
# - apiKey            | add your personal DarkSky secret API key in order
#                     | to download weather forecast information
# - uni               | Return weather conditions in the requested units.
#                     | auto: automatically select units based on geographic location
#                     | ca: same as si, except that windSpeed is in kilometers per hour
#                     | uk2: same as si, except that nearestStormDistance and
#                            visibility are in miles and windSpeed is in miles per hour
#                     | us: Imperial units
#                     | si: SI units (more: https://darksky.net/dev/docs)
# - language          | desired language in which summarys will get display
#                     | (more: https://darksky.net/dev/docs)
# - accent            | accent color
# - refreshFrequency  | sets refresh rate of widget, change value outside of brackets to modify
#                     | number of minutes before freshly updated weather forecasting information appearance
#                     | on your screen (remember: Free tier of DarkSky.io allows up to 1000 refreshs per day
#                     | - also depends on the number of locations you added to your widget)
# - refresh_button    | add a refresh button to the header (! 10/24/2017: currently not supported !)
#
# -----
#
# LOCATION:
# Adding locations follows a easy to understand principle.
# 1. create an id for your location (e.g. 'lnd')
# 2. add a name to your location which later will be displayed on your widget (e.g. 'London, GB')
# 3. add 'Latitude' as well as 'Longitude' information (e.g. 51.5287718 and -0.2416814)
#    you can grab those information from Google Maps:
#      3.1. open maps.google.com
#      3.2. search for your desired location
#      3.3. grab the URL:
#           https://www.google.com/maps/place/London,+United+Kingdom/@51.5287718,-0.2416814,11z/
#                   you can find the importand information here -->   ^^^^^^^^^^ ^^^^^^^^^^
#
#           all in all the 'location:' section will look like the following:
#
#             location: #<-- do not remove this part
#               lnd:
#                 name: 'London, GB'
#                 lat: 51.5287718
#                 lng: -0.2416814
#
#           every other location can be added just like that:
#
#             location: #<-- do not remove this part
#               lnd:
#                 name: 'London, GB'
#                 lat: 51.5287718
#                 lng: -0.2416814
#               prs:
#                 name: 'Paris, FR'
#                 lat: 48.8589507
#                 lng: 2.2770202
#
# ----------


apiKey: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
units: 'si'
language: 'en'
accent: 'rgba(0, 91, 255, 0.6)'
refreshFrequency: (1000 * 60) * 30
refresh_button: false

locations:
  prs:
    name: 'Paris, FR'
    lat: 48.8589507
    lng: 2.2770202
  lnd:
    name: 'London, GB'
    lat: 51.5287718
    lng: -0.2416814
  nyc:
    name: 'New York City, NY'
    lat: 40.6976701
    lng: -74.2598661

# ------------------------
# -----  Code below  -----
# ------------------------

style: """
  right: 8px;
  top: 200px;

  #wttr {
    background: rgba(255, 255, 255, .5);
    width: 300px;
    border-radius: 7px;
    //border: 1px solid rgba(0,0,0,0.2);
    box-shadow: 0 0 20px 0 rgba(0,0,0, 0.4);
    -webkit-backdrop-filter: blur(5px);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    font-family: '-apple-system';
    border-top: none;
    .heading {
      width: 100%;
      background: rgba(255, 255, 255, 0.3);
      border-bottom: 1px solid rgba(50,50, 50, .4);
      position: relative;
    }
    h1 {
      margin: 0;
      padding: 5px 0;
      text-align: center;
      font-size: 12px;
      font-family: '-apple-system';
      font-weight: 400;
    }
    .heading .info img,
    .heading .refresh img {
      position: absolute;
      width: 12px;
      top: 50%;
      transform: translateY(-50%);
      opacity: 0.4;
    }
    .heading .info img {
      right: 6px;
    }
    .heading .refresh img {
      left: 6px;
    }
    .heading .info:hover,
    .heading .refresh:hover {
      cursor: pointer;
    }
    .input {
      position: absolute;
      top: 100%;
      margin: 15px 3px;
      z-index: 9999;
    }
    .heading .input:hover {
      cursor: pointer;
    }
    .input img {
      height: 15px;
      opacity: 0.4;
    }
    #right {
      right: 0;
    }
    #right.inactive {
      display: none;
    }
    #left {
      left: 0;
    }
    #left.inactive {
      display: none;
    }
    #indicators{
      position: absolute;
      bottom: 10px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
    }
    .indicator_el {
      width: 6px;
      margin: 2px;
      height: 6px;
      border-radius: 50%;
      border: 1.5px solid rgba(255, 255, 255, .4);
      &:hover {
        cursor: pointer;
      }
    }
    .indicator_el.active {
      background: rgba(255, 255, 255, .6);
      border: 1.5px solid rgba(255, 255, 255, 0);
    }
    #content {
      display: flex;
      flex-direction: row;
      transition: all ease-in-out .4s;
    }
    .location {
      width: 100%;
    }
    .current {
      display: flex;
      flex-direction: column;
      position: relative;
    }
    .current.passiv .icon,
    .current.passiv .wth-block {
      opacity: 0;
      transition: all ease-in-out 0.4s;
    }
    .overlay {
      position: absolute;
      Z-index: 999;
      width: 100%;
      height: 100%;
      opacity: 0;
      transition: opacity ease-in-out 0.4s;
      background: rgba(255,255,255,0.1);
      #api_credits {
        position: absolute;
        bottom: 5px;
        right: 5px;
        img {
          height: 20px;
        }
      }
      #timestamp {
        position: absolute;
        left: 21px;
        bottom: 6px;
        p {
          font-size: 5px;
          opacity: 0.4;
          color: black;
          margin: 0;
        }
      }
    }
    .overlay.active {
      opacity: 1;
      transition: opacity ease-in-out 0.4s;
    }
    .overlay__inner {
      padding: 15px 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: calc(100% - 2 * 15px);
      .author{
        display: flex;
        justify-content: flex-start;
        align-items: center;
        a {
          text-decoration: none;
          letter-spacing: 0.02em;
          display: block;
          margin: 1px 0 1px 5px;
        }
      }
      #bk_logo img {
        height: 24px;
        vertical-align: bottom;
      }
      a,
      p {
        font-size: 8px;
        color: black;
        margin: 0;
      }
      p {
        margin-bottom: 5px;
        &:last-of-type {
          margin-top: 10px;
          margin-bottom: 0;
        }
      }
    }
    .icon {
      display: flex;
      align-items: center;
      justify-content: center;
      height: 150px;
      transition: all ease-in-out 0.4s;
    }
    .icon img {
      width: 100px;
      height: auto;
      opacity: 0.5;
    }
    .wth-block {
      max-width: 100% !important;
      overflow: hidden;
      position: relative;
      display: flex;
      width: 100%;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
      transition: all ease-in-out 0.4s;
    }
    .wth-infoframe {
      display: flex;
      align-items: center;
      width: 80%;
    }
    .temperature {
      height: 70px;
      padding: 0 10px 0 15px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .temperature p {
      font-size: 50px;
      font-weight: 300;
      margin: 0;
      color: rgba(0,0,0, 0.4)
    }
    .temperature p:after {
      content: '°';
      display: inline;
      font-weight: 200;
      opacity: 0.5;
    }
    .wth-info {
      display: flex;
      flex-direction: column;
      width: 100%;
    }
    .summary p {
      font-size: 17px;
      font-weight: 200;
      color: rgba(0,0,0, 0.5)
      margin: 0 0 1px 0;
      overflow: hidden;
      width: 95%;
      text-overflow: ellipsis;
      // as seen on http://dropshado.ws/post/1015351370/webkit-line-clamp
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
    }
    .name p{
      font-size: 12px;
      font-weight: 600;
      color: rgba(0,0,0, 0.3)
      margin: 1px 0 0 0;
    }
    .wth-date {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 20%;
      height: 65px;
      background: rgba(0,0,0,0.5);
    }
    .wth-date .day p {
      margin: 0
      color: rgba(255, 255, 255, 0.7);
      margin-top: 2px;
      font-size: 16px;
      font-weight: 600;
    }
    .wth-date .month p {
      margin: 0
      color: rgba(255, 255, 255, 0.7);
      margin-bottom: 2px;
      font-size: 10px;
      font-weight: 600;
      text-transform: uppercase;
    }
    .week-forecast {
      background: rgba(0,0,0,0.7);
      max-width: 100%;
      overflow: hidden;
      position: relative;
      display: flex;
      justify-content: space-between;
      padding: 20px 0 40px;
    }
    .shadow {
      width: 110%;
      height: 110%;
      position: absolute;
      top: 0;
      left: 0;
      margin-left:-5%;
      margin-right: -5%;
      box-shadow: inset 0px 0px 10px 0px rgba(0,0,0,0.3);
    }
    .day {
      display: flex;
      align-items: center;
      flex-direction: column;
      width: 33%;
    }
    .day-icon img {
      height: 30px;
      width: auto;
      opacity: 0.5;
    }
    .day-name {
      width: 100%;
      text-align: center;
      background: rgba(255, 255, 255, 0.1);
      padding: 4px 0;
      margin-top: 5px;
    }
    .day-name p {
      color: rgba(255, 255, 255, 0.3);
      text-transform: uppercase;
      font-size: 12px;
      font-weight: 700;
      margin: 0;
    }
    .max-min {
      height: 50px;
      width: 100%;
      background: rgba(255, 255, 255, 0.1);
      position: relative;
      margin: 10px 0;
    }
    .max-min:after {
      content: '';
      width: 1px;
      height: 60%;
      position: absolute;
      background: rgba(155, 155, 155, 0.3);
      top: 50%;
      left: 50%;
      transform: rotate(-45deg) translate(0px,-50%);
      transform-origin: 0 0;
    }
    .value {
      width: 45%;
      position: relative;
    }
    .value p {
      color: rgba(255, 255, 255, 0.4);
      margin: 6px 0;
      font-size: 12px;
    }
    .value:first-of-type {
      margin-left: auto;
      margin-right: 0;
    }
    .value:first-of-type p {
      transform: translateY(30%);
    }
    .value:last-of-type p {
      transform: translateY(-30%);
      text-align: right;
    }
    .value p:after {
      content: '°';
      color: rgba(255, 255, 255, 0.2);
      font-weight: 100;
      margin-left: 1px;
    }
    .rain-frame {
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }
    .rain-el p {
      color: rgba(255, 255, 255, 0.4);
      font-size: 12px;
      margin: 0;
    }
    .rain-el p:after {
      content: '%';
      color: rgba(255, 255, 255, 0.2);
      font-weight: 100;
      margin-left: 2px;
    }
    .rain-img {
      display: flex;
      justify-content: center;
      margin-right: 8px;
    }
    .rain-img img {
      width: 7px;
      opacity: 0.3;
    }
  }
"""

command: "echo {}"

render: (o) -> """
  <div id="wttr">
    <div class="heading">
      <h1>Weather</h1>
      <span class="info"></span>
      <span class="refresh"></span>
      <div class="overlay">
        <div class="overlay__inner">
          <div class="author">
            <div id="bk_logo"></div>
            <div>
              <a href="http://www.bastiankroggel.com">www.bastiankroggel.com</a>
              <a href="http://twitter.bastiankroggel.com">@derKroggel</a>
            </div>
          </div>
          <div>
            <p>
              Based on the <a href="https://github.com/rabad/uebersicht-multiple-locations-weather">Multiple Locations Weather widget</a> by <a href="https://github.com/rabad">Rubén Abad</a>. While major parts of this widget were rewritten it still makes use of the original data access and parse functions.
            </p>
            <p>
              Design-wise this widget is highly influenced by <a href="https://dribbble.com/shots/1563616-SimpL-Weather-Widget-PSD">a dribble shot</a> by the wonderfully talented <a href="https://twitter.com/zramos94">Zahir Ramos</a>.
            </p>
            <p>
              The gorgeous <a href="http://erikflowers.github.io/weather-icons/">weather icons</a> are crafted by <a href="http://www.helloerik.com/">Erik Flowers</a> and can not just be used as standalone icons but also as an easy to implement font.
            </p>
            <p>
              Of course credits, where credits belong - so thank you very much <a href="https://twitter.com/Felx">Felix</a> for creating and maintaining <a href="http://tracesof.net/uebersicht/">Übersicht</a>.
            </p>
            <p>
              In case of questions, errors or suggestions for an improvement feel free to get in touch with me and of course checkout the Readme on <a href="https://github.com/bkroggel/wttr/blob/master/README.md">Github</a>.
            </p>
            <p>
              &copy; 2017 - Bastian Kroggel
            </p>
          </div>
          <div id="api_credits">
            <a href="https://darksky.net/poweredby/">
              <img src="https://darksky.net/dev/img/attribution/poweredby-oneline.png">
            </a>
          </div>
          <div id="timestamp"><p></p></div>
        </div>
      </div>
    </div>
    <div id="content">

    </div>
    <div id="indicators"></div>
  </div>
"""

afterRender: (dom) ->
  #outputs how many locations are specified above
  loc_num = Object.keys(@locations).length
  #calculates the frame-width of the whole widget
  $('#wttr #content').css('width', loc_num * 100 + '%')
  #in case there is more than one location specified above navigation arrows will be attached
  if loc_num > 1
    $('#wttr .heading').append('<div id="left" class="input"><img src="wttr.widget/icon/black/left.png"></img></div><div id="right" class="input"><img src="wttr.widget/icon/black/right.png"></img></div>')
  #adds info button & authors logo
  $(dom).find('#wttr .heading .info').html('<img src="wttr.widget/icon/black/info.png"></img>')
  $(dom).find('#wttr .heading .overlay #bk_logo').html('<img src="wttr.widget/icon/black/bk.png"></img>')
  #adds refresh button (currently disabled since there is apparently no way to call @refresh() by clicking a button)
  if @refresh_button is true
    $(dom).find('#wttr .heading .refresh').html('<img src="wttr.widget/icon/white/refresh.png"></img>')
  #Creates underlying DOM structure (for every location added above)
  for id, _ of @locations
    locationDiv = document.createElement('div')
    locationDiv.setAttribute('id', id)
    locationDiv.setAttribute('class', 'location')
    $(dom).find('#wttr #content').append(locationDiv)
    currentDiv = document.createElement('div')
    currentDiv.setAttribute('id', 'current-' + id)
    currentDiv.setAttribute('class', 'current')
    $(dom).find('#wttr #content #' + id).append(currentDiv)

    iconDiv = document.createElement('div')
    iconDiv.setAttribute('class', 'icon')
    $(dom).find('#wttr #content #' + id + ' #current-' + id).append(iconDiv)

    currentBlock = document.createElement('div')
    currentBlock.setAttribute('id', 'wth-block-' + id)
    currentBlock.setAttribute('class', 'wth-block')
    $(dom).find('#wttr #current-' + id).append(currentBlock)

    TempInfoFrame = document.createElement('div')
    TempInfoFrame.setAttribute('id', 'wth-infoframe-' + id)
    TempInfoFrame.setAttribute('class', 'wth-infoframe')
    $(dom).find('#wttr #content #' + id + ' #current-' + id + ' #wth-block-' + id).append(TempInfoFrame)

    temperatureDiv = document.createElement('div')
    temperatureDiv.setAttribute('class', 'temperature')
    $(dom).find('#wttr #content #' + id + ' #current-' + id + ' #wth-block-' + id + ' #wth-infoframe-' + id).append(temperatureDiv)
    $(dom).find('#wttr #content #' + id + ' #current-' + id + ' #wth-block-' + id + ' #wth-infoframe-' + id + ' .temperature').append(document.createElement('p'))

    currentInfo = document.createElement('div')
    currentInfo.setAttribute('id', 'wth-info-' + id)
    currentInfo.setAttribute('class', 'wth-info')
    $(dom).find('#wttr #current-' + id + ' #wth-block-' + id + ' #wth-infoframe-' + id).append(currentInfo)

    summaryDiv = document.createElement('div')
    summaryDiv.setAttribute('class', 'summary')
    $(dom).find('#wttr #current-' + id + ' #wth-info-' + id).append(summaryDiv)
    $(dom).find('#wttr #current-' + id + ' #wth-info-' + id + ' .summary').append(document.createElement('p'))
    nameDiv = document.createElement('div')
    nameDiv.setAttribute('class', 'name')
    $(dom).find('#wttr #current-' + id + ' #wth-info-' + id).append(nameDiv)
    $(dom).find('#wttr #current-' + id + ' #wth-info-' + id + ' .name').append(document.createElement('p'))

    currentDate = document.createElement('div')
    currentDate.setAttribute('id', 'wth-date-' + id)
    currentDate.setAttribute('class', 'wth-date')
    $(dom).find('#wttr #current-' + id + ' #wth-block-' + id).append(currentDate)

    if @accent #incase there is a specified accent collor
      $(dom).find('#wttr .wth-date').css 'background', @accent

    currentMonth = document.createElement('div')
    currentMonth.setAttribute('class', 'month')
    $(dom).find('#wttr #current-' + id + ' #wth-date-' + id).append(currentMonth)
    $(dom).find('#wttr #current-' + id + ' #wth-date-' + id + ' .month').append(document.createElement('p'))
    currentDay = document.createElement('div')
    currentDay.setAttribute('class', 'day')
    $(dom).find('#wttr #current-' + id + ' #wth-date-' + id).append(currentDay)
    $(dom).find('#wttr #current-' + id + ' #wth-date-' + id + ' .day').append(document.createElement('p'))

    indicatorDiv = document.createElement('div')
    indicatorDiv.setAttribute('id', id + '-indicator')
    indicatorDiv.setAttribute('class', 'indicator_el')
    $(dom).find('#wttr #indicators').append(indicatorDiv)

    weekForecastDiv = document.createElement('div')
    weekForecastDiv.setAttribute('id', id + '-week')
    weekForecastDiv.setAttribute('class', 'week-forecast')
    $(dom).find('#wttr #content #' + id).append(weekForecastDiv)

    #adds shadow to lower part of widget
    shadowDiv = document.createElement('div')
    shadowDiv.setAttribute('class', 'shadow')
    $(dom).find('#wttr #content #' + id + ' #' + id + '-week').append(shadowDiv)

    for idx in [1..3] #three days weather forecast
      dayDiv = document.createElement('div')
      dayDiv.setAttribute('class', 'day')
      dayDiv.setAttribute('id', id + '-plus-' + idx)
      $(dom).find('#wttr #content #' + id + '-week').append(dayDiv)

      dayIconDiv = document.createElement('div')
      dayIconDiv.setAttribute('class', 'day-icon')
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx).append(dayIconDiv)

      maxMinDiv = document.createElement('div')
      maxMinDiv.setAttribute('class', 'max-min')
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx).append(maxMinDiv)

      maxTempDiv = document.createElement('div')
      maxTempDiv.setAttribute('class', 'max-frame value')
      minTempDiv = document.createElement('div')
      minTempDiv.setAttribute('class', 'min-frame value')

      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .max-min').append(maxTempDiv)
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .max-min').append(minTempDiv)
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .max-min .max-frame').append(document.createElement('p'))
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .max-min .min-frame').append(document.createElement('p'))

      rainProbDiv = document.createElement('div')
      rainProbDiv.setAttribute('class', 'rain-frame')
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx ).append(rainProbDiv)
      rainProbImg = document.createElement('div')
      rainProbImg.setAttribute('class', 'rain-img')
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .rain-frame').append(rainProbImg)
      rainProbEl = document.createElement('div')
      rainProbEl.setAttribute('class', 'rain-el')
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .rain-frame').append(rainProbEl)
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .rain-frame .rain-el').append(document.createElement('p'))

      dayNameDiv = document.createElement('div')
      dayNameDiv.setAttribute('class', 'day-name')
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx ).append(dayNameDiv)
      $(dom).find('#wttr #content #' + id + '-week #' + id + '-plus-' + idx + ' .day-name').append(document.createElement('p'))



update: (o, dom) ->
  expiration_date = new Date();
  expiration_date.setTime(expiration_date.getTime()+(1000*60*60*48))
  expiration_date = expiration_date.toGMTString(); #sets expiration date for values stored in cookies
  apiKey = @apiKey #forecast.io apiKey
  units = @units
  language = @language #prefered language for forecast.io output
  #months and days used to display the titles instead of numbers (for days and months)
  months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];

  #function to read cookie
  getCookie = (name) ->
    nameEQ = name + "="
    ca = document.cookie.split(";")
    i = 0
    while i < ca.length
      c = ca[i]
      c = c.substring(1, c.length)  while c.charAt(0) is " "
      return c.substring(nameEQ.length, c.length)  if c.indexOf(nameEQ) is 0
      i++
    null

  $.each @locations, (id, location) ->
    url = "https://api.forecast.io/forecast/" + apiKey + "/" + location.lat + ","+ location.lng + "?units=" + units + "&exclude=minutely,hourly,alerts,flags&lang=" + language
    $.ajax({
      url: url
      type: 'GET',
      crossDomain: true,
      dataType: 'jsonp',
      success: (obj) -> #in case there is a valid internet connection and JSON request is succesfull
        data = obj
        return unless data.currently? || data.daily?
        # extract needed data from JSON
        t = data.currently.apparentTemperature
        s1 = data.currently.icon
        s1 = s1.replace(/-/g, "_")
        r = data.currently.precipProbability
        sm = data.currently.summary
        l = location.name
        d = data.currently.time
        date = new Date(d*1000)
        #attach extracted data to DOM
        $(dom).find('#' + id + ' .name p').text(l)
        $(dom).find('#' + id + ' .summary p').text(sm)
        $(dom).find('#' + id + ' .icon').html('<img src="wttr.widget/icon/black/' + s1 + '.png"></img>')
        $(dom).find('#' + id + ' .temperature p').text(Math.round(t))
        $(dom).find('#' + id + ' #current-' + id + ' .month p').text(months[date.getMonth()])
        $(dom).find('#' + id + ' #current-' + id + ' .day p').text(date.getDate())
        $(dom).find('.heading .overlay #timestamp p').text(new Date(new Date().getTime()))
        #loop for forecast days (limited to 3 -> there are just 3 elements to attach the information to)
        $.each data.daily.data, (idx, day) ->
          xx = new Date()
          xx.setTime(day.time*1000)
          $(dom).find('#' + id + '-plus-' + (idx + 1) + ' .day-name p').text(days[xx.getDay()])
          $(dom).find('#' + id + '-plus-' + (idx + 1) + ' .rain-el p').text(Math.round(day.precipProbability * 100))
          $(dom).find('#' + id + '-plus-' + (idx + 1) + ' .max-frame p').text(Math.round(day.apparentTemperatureMax))
          $(dom).find('#' + id + '-plus-' + (idx + 1) + ' .min-frame p').text(Math.round(day.apparentTemperatureMin))
          s2 = day.icon
          s2 = s2.replace(/-/g, "_")
          $(dom).find('#' + id + '-plus-' + (idx + 1) + ' .day-icon').html('<img src="wttr.widget/icon/white/' + s2 + '.png"></img>')
          $(dom).find('#' + id + '-plus-' + (idx + 1) + ' .rain-frame .rain-img').html('<img src="wttr.widget/icon/white/rain-prob.png"></img>')
          #set cookies to access (stored)data even if connection is broken
          #expiration date is set to 24h
          document.cookie = id + '_' + idx + '_apparentTemperatureMax=' + day.apparentTemperatureMax + ' ; expires=' + expiration_date + '; path=/'
          document.cookie = id + '_' + idx + '_apparentTemperatureMin=' + day.apparentTemperatureMin + ' ; expires=' + expiration_date + '; path=/'
          document.cookie = id + '_' + idx + '_precipProbability=' + day.precipProbability + ' ; expires=' + expiration_date + '; path=/'
          document.cookie = id + '_' + idx + '_icon=' + day.icon + ' ; expires=' + expiration_date + '; path=/'
          document.cookie = id + '_' + idx + '_time=' + day.time + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = id + '_apparentTemperature=' + t + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = id + '_icon=' + s1 + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = id + '_precipProbability=' + r + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = id + '_summary=' + encodeURIComponent(sm) + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = id + '_time=' + d + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = id + '_location=' + encodeURIComponent(l) + ' ; expires=' + expiration_date + '; path=/'
        document.cookie = 'timestamp=' + (new Date(new Date().getTime())) + ' ; expires=' + expiration_date + '; path=/'


      #in case connection is broken and there is no way to access forecast.io data
      #the following function will access the previously stored forecast information
      error: (obj) ->
        #accessing stored information
        t = getCookie(id + '_apparentTemperature')
        s1 = getCookie(id + '_icon')
        s1 = s1.replace(/-/g, "_")
        sm = decodeURIComponent(getCookie(id + '_summary'))
        d = getCookie(id + '_time')
        l = decodeURIComponent(getCookie(id + '_location'))
        timestamp = getCookie('timestamp')
        #attacing information to DOM
        date = new Date(d*1000)
        $(dom).find('#' + id + ' .name p').text(l)
        $(dom).find('#' + id + ' .summary p').text(sm)
        $(dom).find('#' + id + ' .icon').html('<img src="wttr.widget/icon/black/' + s1 + '.png"></img>')
        $(dom).find('#' + id + ' .temperature p').text(Math.round(t))
        $(dom).find('#' + id + ' #current-' + id + ' .month p').text(months[date.getMonth()])
        $(dom).find('#' + id + ' #current-' + id + ' .day p').text(date.getDate())
        $(dom).find('.heading .overlay #timestamp p').text(timestamp)
        for idx in [1..3] #loop for the 3 forecast days
          #accessing stored information
          apparentTemperatureMax = getCookie(id + '_' + (idx - 1) + '_apparentTemperatureMax')
          apparentTemperatureMin = getCookie(id + '_' + (idx - 1) + '_apparentTemperatureMin')
          precipProbability = getCookie(id + '_' + (idx - 1) + '_precipProbability')
          icon = getCookie(id + '_' + (idx - 1) + '_icon')
          time = getCookie(id + '_' + (idx - 1) + '_time')
          #attaching information to DOM
          xx = new Date()
          xx.setTime(time*1000)
          $(dom).find('#' + id + '-plus-' + (idx) + ' .day-name p').text(days[xx.getDay()])
          $(dom).find('#' + id + '-plus-' + (idx) + ' .rain-el p').text(Math.round(precipProbability * 100))
          $(dom).find('#' + id + '-plus-' + (idx) + ' .max-frame p').text(Math.round(apparentTemperatureMax))
          $(dom).find('#' + id + '-plus-' + (idx) + ' .min-frame p').text(Math.round(apparentTemperatureMin))
          s2 = icon
          s2 = s2.replace(/-/g, "_")
          $(dom).find('#' + id + '-plus-' + (idx) + ' .day-icon').html('<img src="wttr.widget/icon/white/' + s2 + '.png"></img>')
          $(dom).find('#' + id + '-plus-' + (idx) + ' .rain-frame .rain-img').html('<img src="wttr.widget/icon/white/rain-prob.png"></img>')
    })

  # inital variables for click functions
  locs = Object.keys(@locations)
  loc_num = Object.keys(@locations).length
  el_mov = 0

  locFrame = $('#content')

  #dissables navigation arrows in case of first/last element
  arrow_controlls = ->
    if locIndex is (loc_num - 1)
      $('#right').addClass 'inactive'
    if $('#left').hasClass('inactive') and locIndex > 0
      $('#left').removeClass 'inactive'
    if locIndex is 0
      $('#left').addClass 'inactive'
    if $('#right').hasClass('inactive') and locIndex < (loc_num - 1)
      $('#right').removeClass 'inactive'

  #sets initially active indication dot
  indicator_num = Object.keys(@locations)[0]
  $('#indicators #' + indicator_num + '-indicator').addClass 'active'
  $('#left').addClass 'inactive'

  #controlls the appearance of indication dots
  indicator_controlls = ->
    indicator_num = locs[locIndex]
    $('#indicators .active').removeClass 'active'
    $('#indicators #' + indicator_num + '-indicator').addClass 'active'

  #stores current location in cookie
  current_location = ->
    document.cookie = 'locIndex=' + locIndex + ' ; expires=' + expiration_date + '; path=/'

  #keeps focused location after refresh
  locIndex = getCookie('locIndex')
  if locIndex?
    move_per_element = -(100/loc_num)
    el_mov = locIndex * move_per_element
    locFrame.css('transform', 'translateX(' + el_mov + '%)')
    arrow_controlls()
    indicator_controlls()
  else
    locIndex = 0

  #allows to click on indication dots
  $.each @locations, (id, location) ->
    $(dom).find('#' + id + '-indicator').click ->
      move_per_element = -(100/loc_num)
      choosen_pos = locs.indexOf(id)
      new_ind_rel = choosen_pos - locIndex
      currentMove = new_ind_rel * move_per_element
      el_mov = currentMove + el_mov
      locFrame.css('transform', 'translateX(' + el_mov + '%)')
      locIndex = choosen_pos
      arrow_controlls()
      indicator_controlls()
      current_location()

  #gets called when interacting with the right navigation arrow
  $(dom).find('#right').click ->
    el_mov = el_mov - (100/loc_num)
    locIndex++
    locFrame.css('transform', 'translateX(' + el_mov + '%)')
    indicator_controlls()
    arrow_controlls()
    current_location()

  #gets called when interacting with the left navigation arrow
  $(dom).find('#left').click ->
    el_mov = el_mov + (100/loc_num)
    locIndex--
    locFrame.css('transform', 'translateX(' + el_mov + '%)')
    arrow_controlls()
    indicator_controlls()
    current_location()

  #toggles credit section
  $(dom).find('.info').click ->
    if $('.current').hasClass( "passiv" )
        $('.current').removeClass( "passiv" )
        $('.overlay').removeClass( "active" )
    else
        overlay_height = $('.current').height()
        $('.current').addClass( "passiv" )
        $('.overlay').addClass( "active" ).css('height', overlay_height + 1 )
