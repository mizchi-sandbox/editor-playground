## test for react jade
jade = require 'react-jade'
template = jade.compileFile(__dirname + '/../templates/markdown-editor.jade')

marked = require 'marked'
marked.setOptions
  highlight: (code) ->
    require('highlight.js').highlightAuto(code).value

codemirrorLoader = require '../lib/codemirror-loader'

module.exports = React.createClass
  onClickTogglePreview: ->
    @setState showPreview: !@state.showPreview

  getInitialState: ->
    previewBuffer: ''
    showPreview: false

  componentDidMount: ->
    el = @refs.editor.getDOMNode()
    cm = @codemirror = codemirrorLoader el

    cm.on 'change', (ev) =>
      code = cm.getValue()
      @setState previewBuffer: code

  render: ->
    raw = @state.previewBuffer
    html = marked raw
    showPreview = @state.showPreview

    template {html, @onClickTogglePreview, showPreview}
