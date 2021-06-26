const { EnvironmentPlugin } = require('webpack')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')
const { WebpackManifestPlugin } = require('webpack-manifest-plugin')
const path = require('path')

module.exports = {
  mode: 'development',
  entry: {
    application: [
      'entrypoints/application.js',
      'entrypoints/application.scss',
    ]
  },
  resolve: {
    extensions: [
      '.mjs',
      '.js',
      '.sass',
      '.scss',
      '.css',
      '.module.sass',
      '.module.scss',
      '.module.css',
      '.png',
      '.svg',
      '.gif',
      '.jpeg',
      '.jpg'
    ],
    modules: [
      'app/packs',
      'node_modules',
    ]
  },
  output: {
    filename: 'js/[name]-[hash].js',
    chunkFilename: 'js/[name]-[hash].chunk.js',
    hotUpdateChunkFilename: 'js/[id]-[hash].hot-update.js',
    path: path.resolve(__dirname, '../../public/packs'),
    publicPath: '/packs/',
  },
  module: {
    strictExportPresence: true,
    rules: [
      {
        test: /(.jpg|.jpeg|.png|.gif|.tiff|.ico|.svg|.eot|.otf|.ttf|.woff|.woff2)$/i,
        use: [ { loader: 'file-loader', } ]
      },
      {
        test: /\.(css)$/i,
        use: [
          'node_modules/mini-css-extract-plugin/dist/loader.js',
          { loader: 'css-loader', },
          { loader: 'postcss-loader', },
        ],
        sideEffects: true,
        exclude: /\.module\.[a-z]+$/
      },
      {
        test: /\.(scss|sass)(\.erb)?$/i,
        use: [
          'mini-css-extract-plugin/dist/loader.js',
          { loader: 'css-loader', },
          { loader: 'postcss-loader', },
          { loader: 'sass-loader', },
        ],
        sideEffects: true,
        exclude: /\.module\.[a-z]+$/
      },
      {
        test: /\.(js|mjs)$/,
        include: /node_modules/,
        exclude: /(?:@?babel(?:\/|\\{1,2}|-).+)|regenerator-runtime|core-js|^webpack$|^webpack-assets-manifest$|^webpack-cli$|^webpack-sources$|^@rails\/webpacker$/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              babelrc: false,
              presets: [
                [
                  '@babel/preset-env',
                  { modules: false },
                ],
              ],
              cacheDirectory: true,
              cacheCompression: false,
              compact: false,
            }
          },
        ]
      },
      {
        test: /\.(js|jsx|mjs|ts|tsx)?(\.erb)?$/,
        include: [ path.resolve(__dirname, '../../app/packs') ],
        exclude: /node_modules/,
        use: [
          {
            loader: 'babel-loader',
            options: {
              cacheDirectory: true,
              cacheCompression: false,
              compact: false
            }
          },
        ]
      },
    ]
  },
  plugins: [
    new EnvironmentPlugin(['NODE_ENV']),
    new MiniCssExtractPlugin({
      filename: 'css/[name]-[contenthash:8].css',
      ignoreOrder: false,
      chunkFilename: 'css/[name]-[contenthash:8].chunk.css'
    }),
    new WebpackManifestPlugin({}),
  ]
}
