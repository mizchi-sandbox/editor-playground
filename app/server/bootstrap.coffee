app = require('app')
BrowserWindow = require('browser-window')

path = require('path')
require('crash-reporter').start()
mainWindow = null

app.on 'window-all-closed', ->
  if process.platform isnt 'darwin'
    app.quit();

app.on 'ready', ->
  mainWindow = new BrowserWindow({width: 800, height: 700})
  mainWindow.loadUrl(path.join('file://', __dirname, '../index.html'))
  mainWindow.on 'closed', ->
    mainWindow = null
