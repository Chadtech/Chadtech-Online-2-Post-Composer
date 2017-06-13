var Elm = require("./elm");
var fs = get("fs");
var remote = get("remote");
var dialog = remote.require("dialog");

var app = Elm.Main.fullscreen();

app.ports.save.subscribe(function(json) {
    dialog.showSaveDialog(function(fn) {
        fs.writeFileSync(fn, json)
    });
})