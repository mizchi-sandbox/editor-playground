window.React = React  = require 'react'
window.Promise = require 'bluebird'

window.addEventListener 'load', ->
  EditorScene = require './scenes/markdown-editor/editor-scene'
  EditorScene.start()
