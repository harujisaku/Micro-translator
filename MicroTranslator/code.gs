function transrateFromJaToEn(word) {
  return LanguageApp.translate(word, 'ja', 'en');
}

function transrateFromEnToJa(word) {
  return LanguageApp.translate(word, 'en', 'ja');
}

function doGet(e) {
  var word = e.parameter.word;
  
  var result = transrateFromJaToEn(word);
  if (word == result) {
    result = transrateFromEnToJa(word);
  }
  
  return createaResponse(result);
}

function createaResponse(word) {
 return ContentService.createTextOutput(word);
}