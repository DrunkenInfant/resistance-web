Ember.Handlebars.registerHelper('eachEven', function (list, options) {
  return this.get(list)
    .filter(function (item, i) { return i % 2 == 0; })
    .map(function (item) { return options.fn(item); })
    .reduce(function (aggr, item) { return aggr + item; }, '');
});

Ember.Handlebars.registerHelper('eachOdd', function (list, options) {
  return this.get(list)
    .filter(function (item, i) { return i % 2 == 1; })
    .map(function (item) { return options.fn(item); })
    .reduce(function (aggr, item) { return aggr + item; }, '');
});
