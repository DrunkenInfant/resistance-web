Ember.Handlebars.registerHelper('eachLeftPlayer', function (list, options) {
  return this.get(list)
    .slice(this.get(list).get('length')/2, this.get(list).get('length'))
    .reverse()
    .map(function (item) { return options.fn(item); })
    .reduce(function (aggr, item) { return aggr + item; }, '');
});

Ember.Handlebars.registerHelper('eachRightPlayer', function (list, options) {
  return this.get(list)
    .slice(0, this.get(list).get('length')/2)
    .map(function (item) { return options.fn(item); })
    .reduce(function (aggr, item) { return aggr + item; }, '');
});
