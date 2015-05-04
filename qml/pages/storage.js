.pragma library
.import QtQuick.LocalStorage 2.0 as SQL

function getDatabase() {
     return  SQL.LocalStorage.openDatabaseSync("one", "1.0", "StorageDatabase", 1000000);
}

function initialize(){
    var db = getDatabase()
    db.transaction(function(tx){
                       tx.executeSql('CREATE TABLE IF NOT EXISTS favorite(date TEXT UNIQUE, title TEXT)')
                   })
}

function addFavorite(date, title){
    var db = getDatabase();
    var res = false;
    db.transaction(function(tx){
                       var rs = tx.executeSql('INSERT OR REPLACE INTO favorite VALUES (?,?);',[date, title])
                       res = rs.rowsAffected > 0;
                   })
    return res;
}

function loadFavorite(model){
    model.clear();
    var db = getDatabase();
    db.readTransaction(function(tx){
                           var rs = tx.executeSql('SELECT * FROM favorite')
                           for (var i=0, l = rs.rows.length; i < l; i++){
                               var t = rs.rows.item(i);
                               model.append({"title":t.title, "date":t.date})
                           }
                       })
}

function removeFavorite(date){
    var db = getDatabase();
    db.transaction(function(tx){
                       tx.executeSql('DELETE FROM favorite WHERE date=?;',[date])
                   })
}
