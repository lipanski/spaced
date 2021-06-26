process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const { merge } = require('webpack-merge')
const base = require('./base')
const path = require('path')

custom = {
  devtool: 'inline-source-map',
  devServer: {
    hot: true,
    inline: true,
    overlay: true,
    disableHostCheck: true,
    watchContentBase: true,
    contentBase: [path.resolve(__dirname, '../../app/views')],
    headers: {
      'Access-Control-Allow-Origin': '*'
    },
  }
}

module.exports = merge(base, custom)
