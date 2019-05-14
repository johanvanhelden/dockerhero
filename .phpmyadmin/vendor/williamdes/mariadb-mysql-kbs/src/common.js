const fs = require('fs');
/**
 * Sort the object keys
 * @see https://stackoverflow.com/a/48112249/5155484
 * @param {object} obj The object
 * @param {function} arraySorter The sorter callback
 */
function sortObject(obj, arraySorter) {
    if (typeof obj !== 'object') return obj;
    if (Array.isArray(obj)) {
        if (arraySorter) {
            obj.sort(arraySorter);
        }
        for (var i = 0; i < obj.length; i++) {
            obj[i] = sortObject(obj[i], arraySorter);
        }
        return obj;
    }
    var temp = {};
    var keys = [];
    for (var key in obj) keys.push(key);
    keys.sort();
    for (var index in keys) temp[keys[index]] = sortObject(obj[keys[index]], arraySorter);
    return temp;
}
exports.writeJSON = function writeJSON(filename, data) {
    fs.writeFile(filename, JSON.stringify(sortObject(data), null, 2) + '\n', function(err) {
        if (err) {
            return console.log(err);
        }
    });
};

exports.readJSON = function readJSON(filename, callbackSuccess) {
    fs.readFile(filename, 'utf8', function(err, data) {
        if (err) {
            return console.log(err);
        }
        callbackSuccess(JSON.parse(data), filename);
    });
};

exports.listDirectory = function readJSON(dirname, callbackSuccess) {
    fs.readdir(dirname, (err, files) => {
        if (err) {
            return console.log(err);
        }
        callbackSuccess(files, dirname);
    });
};
