process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

terserOptions = environment.config.optimization.minimizer[0].options.terserOptions

// keep constructor.name
terserOptions.keep_classnames = true

module.exports = environment.toWebpackConfig()
