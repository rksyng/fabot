Yelp = require 'yelp'

module.exports = (robot) ->
    robot.respond /(腹|お腹)(減った|空いた)/i, (msg) ->
        yelp = new Yelp({
          consumer_key: process.env.YELP_CONSUMER_KEY,
          consumer_secret: process.env.YELP_CONSUMER_SECRET,
          token: process.env.YELP_TOKEN,
          token_secret: process.env.YELP_TOKEN_SECRET
        })

        yelp.search({ term: 'food', location: '港区, 南青山, 6-10-12', radius_filter: 1000, cc: 'JP', lang: 'ja' })
        .then (data) ->
            total = data.businesses.length
            console.log total
            random = Math.floor(Math.random() * total)
            console.log random

            answer = "こんな所はどうでしょう？\n\n"
            answer += data.businesses[random].name + "\n"
            answer += data.businesses[random].url + "\n"
            answer += data.businesses[random].location.display_address + "\n"
            answer += data.businesses[random].image_url + "\n"

            msg.send answer
        .catch (err) ->
            console.log(err)
            msg.send err
