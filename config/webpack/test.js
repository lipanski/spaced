process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const { merge } = require('webpack-merge')
const base = require('./production')
const path = require('path')

custom = {
  output: {
    path: path.resolve(__dirname, '../../public/packs-test'),
    publicPath: '/packs-test/'
  }
}

module.exports = merge(base, custom)
