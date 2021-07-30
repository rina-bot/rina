module.exports = {
  test: /\.pug$/,
  use: [{
    loader: "./app/javascript/lib/pug-vdom-loader.js",
    options: {
      defaultLocals: 'window.DEFAULT_TEMPLATE_LOCALS',
      runtime: `
        var maquetteH = require('maquette').h;
        var h = function(selector, props, children) {
          var attributes = Object.assign({}, props.attributes || {}, props);
          delete attributes["attributes"];

          // This should be done by pug-vdom, oh well...
          if (attributes.class) {
            selector += "." + attributes.class.trim().split(/\\s+/).join(".");
            delete attributes["class"];
          }

          return maquetteH(selector, attributes, children);
        }
      `
    }
  }]
}
