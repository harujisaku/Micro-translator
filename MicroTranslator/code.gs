function doGet(e) {
	var p = e.parameter;
	var t = p.target;
	console.log(t);
	if(!p.target){
	  var translatedText = LanguageApp.translate(p.text, "","ja",{contentType: 'html'});
	return ContentService.createTextOutput(translatedText);
	}
	var translatedText = LanguageApp.translate(p.text, "" , p.target,{contentType: 'html'});
	return ContentService.createTextOutput(translatedText);
}
