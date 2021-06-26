process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const { merge } = require('webpack-merge')
const base = require('./base')

const TerserPlugin = require('terser-webpack-plugin')
const CompressionPlugin = require('compression-webpack-plugin')
const OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin')

custom = {
  mode: 'production',
  optimization: {
    minimize: true,
    minimizer: [
      new TerserPlugin({
        parallel: true,
      }),
    ]
  },
  plugins: [
    new CompressionPlugin({
      test: /\.(js|css|html|json|ico|svg|eot|otf|ttf|map)$/,
    }),
    new OptimizeCssAssetsPlugin(),
  ]
}

module.exports = merge(base, custom)
