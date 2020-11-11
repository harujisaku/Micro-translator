function doGet(e) {
  var p = e.parameter;
  var t = p.target;
  console.log(t);
  if(!p.target){
    var translatedText = LanguageApp.translate(p.text, "","ja");
    return ContentService.createTextOutput(translatedText);
  }
  var translatedText = LanguageApp.translate(p.text, "" , p.target);
  return ContentService.createTextOutput(translatedText);
}
