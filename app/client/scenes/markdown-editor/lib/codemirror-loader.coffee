{Pos} = CodeMirror

autocomplete = (cm) ->
  CodeMirror.showHint cm, ->
    cur   = cm.getCursor()
    token = cm.getTokenAt(cur)
    start = token.start
    end   = token.end
    from  = Pos(cur.line, start)
    to    = Pos(cur.line, end)

    list:[
      "aaa"
      "bbb"
      "ccc"
      ]
    from: from
    to: to

_ = require 'lodash'

collectBufferWords = (cm, word) ->
  bufferWords = _.compact(cm.getValue().split(/\n|\s/))
  _.uniq _.filter bufferWords, (w) ->
    w.indexOf(word) > -1 and w isnt word

autocompleteAnyWords = (cm) ->
  CodeMirror.showHint cm, ->
    cur   = cm.getCursor()
    token = cm.getTokenAt(cur)
    start = token.start
    end   = token.end

    from  = Pos(cur.line, start)
    to    = Pos(cur.line, end)
    currentWord = token.string
    ch = cur.ch
    line = cur.line

    while --ch > -1
      t = cm.getTokenAt({ch, line})
      if t.string is ' '
        break
      currentWord= t.string + currentWord

    matchedWords = collectBufferWords(cm, currentWord)

    list: matchedWords
    from: {ch, line}
    to: to

autocompleteAsync = (cm) ->
  callback = (cm) ->
    cur   = cm.getCursor()
    token = cm.getTokenAt(cur)
    start = token.start
    end   = token.end
    from  = Pos(cur.line, start)
    to    = Pos(cur.line, end)

    setTimeout ->
      CodeMirror.showHint cm, ->
        list:[
          "aaa"
          "bbb"
          "ccc"
          ]
        from: from
        to: to
    , 400

  callback.async = true
  CodeMirror.showHint cm, callback

watchChange = (cm) ->
  CodeMirror.showHint cm, ->
    cur   = cm.getCursor()
    token = cm.getTokenAt(cur)
    start = token.start
    end   = token.end
    from  = Pos(cur.line, start)
    to    = Pos(cur.line, end)

    if token.string is '@'
      list:[
        "@aaa"
        "@bbb"
        "@ccc"
        ]
      from: from
      to: to

saveToStorage = (cm) ->
  code = cm.getValue()
  localStorage.buffer = code
  console.log 'save L:', code.length

module.exports = (el) ->
  window.cm = CodeMirror.fromTextArea el,
    fixedGutter: true
    mode: 'gfm'
    height: 900
    lineNumbers: true
    extraKeys:
      'Cmd-S': saveToStorage
      'Tab': autocompleteAnyWords
  cm.setValue localStorage.buffer ? ''

  # show autocomple
  cm.on 'change', ->
    watchChange(cm)
  cm
