var secret = 'insert-firebase-secret-here'

function startSync() {
  var sheet = SpreadsheetApp.getActiveSheet()
  var [rows, columns] = [sheet.getLastRow(), sheet.getLastColumn()]
  var data = sheet.getRange(2, 1, rows-1, columns).getValues()
  syncMasterSheet(data)
}

function syncMasterSheet(excelData) {
  var options = {
    method: 'put',
    contentType: 'application/json',
    payload: JSON.stringify(excelData)
  }
  var fireBaseUrl = getFirebaseUrl('words')
  UrlFetchApp.fetch(fireBaseUrl, options)
}


function getFirebaseUrl(jsonPath) {
  return (
    'https://my-first-project-244715.firebaseio.com/' +
    jsonPath +
    '.json?auth=' +
    secret
  )
}




