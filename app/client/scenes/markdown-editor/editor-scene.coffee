MarkdownEditor = require './components/markdown-editor'

module.exports =
class EditorScene
  @start: ->
    React.render MarkdownEditor({contentBuffer: ''}), document.body
