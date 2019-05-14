'use strict';

process.env.TZ = 'UTC';
const templates = require(__dirname + '/templates');

suite('MariaDB MySQL KBS', function() {
    templates();
});
