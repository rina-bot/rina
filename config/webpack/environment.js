const { environment } = require('@rails/webpacker');
const WebpackAssetsManifest = require('webpack-assets-manifest');

/*const splitChunks = {
  optimization: {
    splitChunks: {
      chunks: 'all'
    },
  },
};

environment.config.merge(splitChunks);*/
environment.plugins.insert(
  'Manifest',
  new WebpackAssetsManifest({
    entrypoints: true, // default in rails is false
    writeToDisk: true, // rails defaults copied from webpacker
    publicPath:  true  // rails defaults copied from webpacker
  })
);

environment.loaders.append('coffee', require('./loaders/coffee'));
environment.loaders.append('pug-vdom', require('./loaders/pug-vdom'));
environment.loaders.prepend('erb', require('./loaders/erb'));

module.exports = environment;
