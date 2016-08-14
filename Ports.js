var container = document.getElementById('app');
var demoApp = Elm.RenderDemo.embed(container);

demoApp.ports.onCellAdded.subscribe(function(cellID) {
   if(document.getElementById('cell:' + cellID) === null) { window.alert("Cannot find cell " + cellID) }

});

