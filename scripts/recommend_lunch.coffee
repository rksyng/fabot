Yelp = require 'yelp'

module.exports = (robot) ->
    robot.hear /(おすすめ)/i, (msg) ->
        yelp = new Yelp({
          consumer_key: process.env.consumer_key,
          consumer_secret: process.env.consumer_secret,
          token: process.env.token,
          token_secret: process.env.token_secret
        })

        yelp.search({ term: 'food', location: '港区南青山6-10-12', radius_filter: 1000, limit: 1, cc: 'JP', lang: 'ja' })
        .then (data) ->
            msg.send data.businesses[0].name
        .catch (err) ->
            console.log(err)
            msg.send err
