var webpack = require("webpack");
var path = require('path');

module.exports = {
  entry: './client/vendor.js',

  output: {
    filename: './static/bundle.js'
  },

  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.jsx$/   , loader: "jsx" },
      { test: /\.less$/  , loader: "style!css!less"},
      { test: /\.css$/   , loader: "style!css?root=." },
      { test: /\.scss$/  , loader: "style!css!sass" },
    ]
  },

  resolve: {
    root: [path.join(__dirname, "bower_components")],
    extensions: ["", ".coffee", ".ts", ".js"]
  },

  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
    )
  ]
}
